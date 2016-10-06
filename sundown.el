(require 'json)
(require 'url)

(setq sundown-timeurl "http://api.sunrise-sunset.org/json")

(defun get-sunstats-json (day lat lng)
  "Requests sundown-timeurl for the sunstats for a specified day
   and returns it as json"
  (let ((args (mapconcat 'identity `(,(concat "location=" lat)
                                     ,(concat "lng=" lng)
                                     ,(concat "date=" day)
                                     "formatted=0")
                                     "&")))
    (with-current-buffer (url-retrieve-synchronously (concat sundown-timeurl "?" args))
      (goto-char url-http-end-of-headers)
      (delete-region (point-min) (point))
      (json-read-from-string (buffer-string)))))

(defun get-sunstats-prop (day lat lng prop)
  "Retrieves the prop \"prop\" from the json result from get-sunstats-json"
  (cdr (assoc prop (assoc 'results (get-sunstats-json day lat lng)))))

(defun is-it-darkp (day lat lng)
  "Checks whether it is dark outside, i.e if the sun has set."
  (let ((sundown (get-sunstats-prop day lat lng 'sunset))
        (current-time (current-time)))
    ;; This does not take DST into consideration
    (time-less-p (date-to-time sundown) current-time)))
