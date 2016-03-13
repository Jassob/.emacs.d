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
                           "~/.todo/dtek.org"
                           "~/.todo/chalmers.org")))
  
  (setq org-agenda-include-diary t)

  :config
  ;; Load DTEK's org definitions
  (load-file
   (concat user-emacs-directory "org-dtek/dtek-latex-settings.el" )))

;;; ----------------------------------------------------------------------------
;;; Configuration for minor mode Org-trello
;;; ----------------------------------------------------------------------------
(use-package org-trello
  :ensure t
  :init
  ;; My org-trello-files
  (setq org-trello-files
	'("~/.todo/todo.org" "~/.todo/presidiet.org" "~/.todo/chalmers.org"))
  (setq org-trello-current-prefix-keybinding
	"C-c o" org-trello))
