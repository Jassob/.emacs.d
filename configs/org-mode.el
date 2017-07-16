;;; ============================================================================
;;; Configuration file for the major mode Org-mode.
;;; -----------------------------------------------
;;; Also contains configuration for some minor modes used in conjunction
;;; with org-mode.
;;;
;;; Author: Jassob
;;; ============================================================================
(use-package org
  :init
  ;; Keybindings
  (global-set-key "\C-cl" 'org-store-link)
  (global-set-key "\C-cc" 'org-capture)
  (global-set-key "\C-ca" 'org-agenda)
  (global-set-key "\C-cb" 'org-iswitchb)

  ;; My personal todo's
  (setq org-agenda-files (quote
                          ("~/.todo/todo.org"
                           "~/.todo/presidiet.org"
                           "~/.todo/chalmers.org")))

  (setq org-agenda-include-diary t)
  (setq org-log-done 'note)
  (setq org-todo-keywords
        '((sequence "TODO(t)" "URGENT(u@/!)" "IN-PROGRESS(p@/!)" "WAITING(w@/!)" "|" "DONE(d@/!) CANCELED(c@)" )

          (sequence "IDEAS(i)")))
  (setq org-log-into-drawer "LOGBOOK")

  :config
  ;; Load DTEK's org definitions
  (load-file
   (concat user-emacs-directory "org-dtek/dtek-latex-settings.el" ))

  (require 'ox-html)
  (setq org-publish-project-alist
  '(("html"
     :base-directory "~/.todo/"
     :base-extension "org"
     :publishing-directory "/ssh:jassob2:/srv/http/org"
     :publishing-function org-html-publish-to-html
     :recursive t)
    ("org-static"
     :base-directory "~/.todo/"
     :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
     :publishing-directory "/ssh:jassob2:/srv/http/org"
     :recursive t
     :publishing-function org-publish-attachment
     )
    ("archive"
     :base-directory "~/.todo/"
     :base-extension "org_archive"
     :publishing-directory "/ssh:jassob2:/srv/http/org/archive"
     :publishing-function org-html-publish-to-html)
    ("html-chalmers"
     :base-directory "~/.todo/"
     :base-extension "org"
     :publishing-directory "/ssh:chalmers:~/www/org"
     :publishing-function org-html-publish-to-html
     :recursive t)
    ("org-static-chalmers"
     :base-directory "~/.todo/"
     :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
     :publishing-directory "/ssh:chalmers:~/www/org"
     :recursive t
     :publishing-function org-publish-attachment
     )
    ("archive-chalmers"
     :base-directory "~/.todo/"
     :base-extension "org_archive"
     :publishing-directory "/ssh:chalmers:~/www/org/archive"
     :publishing-function org-html-publish-to-html)
    ("all" :components ("html-chalmers" "org-static-chalmers" "archive-chalmers")))))
