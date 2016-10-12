(require 'json)
(require 'url)

(setq sundown-timeurl "http://api.sunrise-sunset.org/json")

(setq gothenburg-loc '("57.708870" . "11.974560"))

(defun get-sunstats-json (day loc)
  "Requests sundown-timeurl for the sunstats for a specified day
   and returns it as json. loc is a cons cell consisting of a
   latitude as car and longitude as cdr."
  (let ((args (mapconcat 'identity `(,(concat "lat=" (car loc))
                                     ,(concat "lng=" (cdr loc))
                                     ,(concat "date=" day)
                                     "formatted=0")
                                     "&")))
    (with-current-buffer (url-retrieve-synchronously (concat sundown-timeurl "?" args))
      (goto-char url-http-end-of-headers)
      (delete-region (point-min) (point))
      (json-read-from-string (buffer-string)))))

(defun get-sunstats-prop (day loc prop)
  "Retrieves the prop \"prop\" from the json result from get-sunstats-json.
   loc is a cons cell consisting of (latitude . longitude)"
  (cdr (assoc prop (assoc 'results (get-sunstats-json day loc)))))

(defun is-it-darkp (day loc)
  "Checks whether it is dark outside, i.e if the sun has set.
   loc is a cons cell consisting of (latitude . longitude)"
  (let ((sundown (get-sunstats-prop day loc 'sunset)))
    ;; This does not take DST into consideration
    (time-less-p (date-to-time sundown) (current-time))))
