;;; ============================================================================
;;; Initialize ELPA (Emacs Lisp Package Archive)
;;; ============================================================================
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

;;; ============================================================================
;;; EXWM
;;; ============================================================================
(require 'exwm)
(require 'exwm-config)
(exwm-config-default)

;;; ============================================================================
;;; Keybindings
;;; ============================================================================
(global-set-key (kbd "s-u") 'revert-buffer)

;;; ============================================================================
;;; Hooks
;;; ============================================================================
(defun contextual-menubar (&optional frame)
  "Never show menubar, toolbar or scrollbar."
  (interactive)
  (set-frame-parameter frame 'menu-bar-lines 0)
  (set-frame-parameter frame 'tool-bar-lines 0)
  (set-frame-parameter frame 'vertical-scroll-bars nil))

(add-hook 'after-make-frame-functions 'contextual-menubar)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(remove-hook 'kill-buffer-query-functions 'server-kill-buffer-query-function)

;;; ============================================================================
;;; General stuff
;;; ============================================================================
(when (display-graphic-p)
  (menu-bar-mode -1)
  (tool-bar-mode -1)
  (toggle-scroll-bar -1))

;; Display clock in modeline
(display-time)
(column-number-mode)
(blink-cursor-mode 0)

;; Set a bunch of stuff
(setq initial-scratch-message ""
      inhibit-startup-message t

      ;; Disable visual or graphic error bell
      ring-bell-function 'ignore

      ;; Unset right option key as meta
      ns-right-alternate-modifier nil

      ;; No theme is activated
      activated-theme nil

      ;; don't litter my fs tree (save backups in /tmp)
      backup-directory-alist `((".*" . ,temporary-file-directory))
      auto-save-file-name-transforms `((".*" ,temporary-file-directory t))
      auto-save-list-file-prefix temporary-file-directory
      backup-by-copying t

      ;; Keep at most 4 copies of every file (2 new and then 2 old copies)
      kept-new-versions 2
      kept-old-versions 2
      delete-old-versions t

      ;; use versioned backups
      version-control t)

;; Theming
(load (concat user-emacs-directory "sundown.el"))
(defun dark-or-light-theme (lighttheme darktheme)
  "Checks whether the sun has set and loads the darktheme in that case,
   otherwise it loads the lighttheme instead."
  (interactive)
  ;; Load theme depending on the time of day
  (if (is-it-darkp "today" gothenburg-loc)
      (unless (eq activated-theme 'light)
        (disable-theme lighttheme)
        (load-theme darktheme t)
        (setq activated-theme 'light))
    (unless (eq activated-theme 'dark)
      (disable-theme darktheme)
      (load-theme lighttheme t)
      (setq activated-theme 'dark))))

;; Checks every half hour whether it is time to switch the theme or not.
(run-with-timer 0
                (* 60 30)
                'dark-or-light-theme
                'sanityinc-tomorrow-day
                'sanityinc-tomorrow-night)

;; Don't prompt as much
(fset 'yes-or-no 'y-or-n)

;; Use auto indent mode
(electric-indent-mode t)

;;; ============================================================================
;;; Load separate config files
;;; ============================================================================

(defun load-config (file)
  "Loads a Emacs config file from .emacs.d/configs/$file"
  (load (concat user-emacs-directory "configs/" file)))

(load-config "hs-minor-mode.el")
(load-config "god-mode.el")
(load-config "multiple-cursors.el")
(load-config "helm.el")
(load-config "fancy-battery-mode.el")
(load-config "org-mode.el")
(load-config "magit-mode.el")
(load-config "haskell.el")
(load-config "pandoc-mode.el")
(load-config "python-mode.el")
(load-config "java-mode.el")
(load-config "latex.el")
(load-config "znc.el")
;; For playing music with Emacs
(load-config "emms.el")

