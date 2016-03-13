;;; ============================================================================
;;; Configuration mode for the minor mode hide-show-minor-mode.
;;; -----------------------------------------------------------
;;;
;;; Author: Jassob
;;; ============================================================================
(use-package hideshow
  :ensure t
  :init

  ;; Set toggle hiding and showing region with C-Tab
  (global-set-key (kbd "<C-tab>") 'hs-toggle-hiding)

  :config
  ;; Add hs-minor-mode to some languages
  (add-hook 'c-mode-common-hook   'hs-minor-mode)
  (add-hook 'emacs-lisp-mode-hook 'hs-minor-mode)
  (add-hook 'java-mode-hook       'hs-minor-mode)
  (add-hook 'lisp-mode-hook       'hs-minor-mode)
  (add-hook 'perl-mode-hook       'hs-minor-mode)
  (add-hook 'sh-mode-hook         'hs-minor-mode))
