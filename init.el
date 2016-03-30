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
;; Display clock in modeline
(display-time)

;; Display current column in modeline
(column-number-mode)

;; Don't blink the cursor
(blink-cursor-mode 0)

;; Disable toolbar & scrollbars (for GUI emacs)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)

;; Disable visual or graphic error bell
(setq ring-bell-function 'ignore)

;; Don't use messages that you don't read
(setq initial-scratch-message "")
(setq inhibit-startup-message t)

;; Load Solarized color theme
(use-package color-theme-approximate
  :ensure t
  :config
  (color-theme-approximate-on)
  (load-theme 'twilight-anti-bright t))

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

;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
;(global-set-key (kbd "C-c h") 'helm-command-prefix)
;(global-unset-key (kbd "C-x c"))

;;; ============================================================================
;;; Load separate config files
;;; ============================================================================
(load (concat user-emacs-directory "configs/org-mode.el"))
(load (concat user-emacs-directory "configs/magit-mode.el"))
(load (concat user-emacs-directory "configs/hs-minor-mode.el"))
(load (concat user-emacs-directory "configs/multiple-cursors.el"))
(load (concat user-emacs-directory "configs/haskell.el"))
(load (concat user-emacs-directory "configs/helm.el"))
(load (concat user-emacs-directory "configs/fancy-battery-mode.el"))
(load (concat user-emacs-directory "configs/pandoc-mode.el"))
(load (concat user-emacs-directory "configs/python-mode.el"))
;; For hacking Stumpwm with Emacs
(load (concat user-emacs-directory "configs/slime.el"))

