;;; ============================================================================
;;; Initialize ELPA (Emacs Lisp Package Archive)
;;; ============================================================================
(require 'package) ;; You might already have this line
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)

;;; ============================================================================
;;; General stuff
;;; ============================================================================
(defun contextual-menubar (&optional frame)
  "Never show menubar, toolbar or scrollbar."
  (interactive)
  (set-frame-parameter frame 'menu-bar-lines 0)
  (set-frame-parameter frame 'tool-bar-lines 0)
  (set-frame-parameter frame 'vertical-scroll-bars nil))

(add-hook 'after-make-frame-functions 'contextual-menubar)

(when (display-graphic-p)
  (menu-bar-mode -1)
  (tool-bar-mode -1)
  (toggle-scroll-bar -1))

(load (concat user-emacs-directory "sundown.el"))
(defun dark-or-light-theme (lighttheme darktheme)
  "Checks whether the sun has set and loads the darktheme in that case,
   otherwise it loads the lighttheme instead."
  (interactive)
  ;; Load theme depending on the time of day
  (if (is-it-darkp "today" gothenburg-loc)
      (load-theme darktheme t)
    (load-theme lighttheme t)))

;; Checks every hour whether it is time to switch the theme or not.
(run-with-timer 0
                (* 60 60)
                'dark-or-light-theme
                'sanityinc-tomorrow-day
                'sanityinc-tomorrow-night)



;; Display clock in modeline
(display-time)
;; Display current column in modeline
(column-number-mode)
;; Don't blink the cursor
(blink-cursor-mode 0)
;; Disable menubar
(menu-bar-mode -1)
;; Disable visual or graphic error bell
(setq ring-bell-function 'ignore)

(require 'exwm)
(require 'exwm-config)
(exwm-config-default)

;; Don't prompt as much
(fset 'yes-or-no 'y-or-n)
(remove-hook 'kill-buffer-query-functions 'server-kill-buffer-query-function)

;; Don't use messages that you don't read
(setq initial-scratch-message "")
(setq inhibit-startup-message t)

;; Always delete trailing whitespace
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Use auto indent mode
(electric-indent-mode t)

;; Unset right option key as meta
(setq ns-right-alternate-modifier nil)

;; Revert buffer with S-u
(global-set-key (kbd "s-u") 'revert-buffer)

;; Backups
(setq backup-by-copying t ; don't clobber symlinks

      ;; don't litter my fs tree
      backup-directory-alist '(("." . "~/.saves"))

      ;; Keep at most 4 copies of every file (2 new and then 2 old copies)
      kept-new-versions 2
      kept-old-versions 2
      delete-old-versions t

      ;; use versioned backups
      version-control t)

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

