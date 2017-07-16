;;; ============================================================================
;;; Configuration file for programming in Python with Emacs.
;;; --------------------------------------------------------
;;;
;;; Author: Jassob
;;; ============================================================================

(use-package python-mode
  :ensure t
  :init
  (use-package smart-tabs-mode
    :ensure t
    :init
    (smart-tabs-insinuate 'c 'c++ 'javascript 'ruby 'nxml)
  (use-package flymake
    :init
    (add-hook 'python-mode-hook 'flymake-mode)
    (setq pep8-flymake-mode t))
  :config
  (setq py-dedicated-process-p t)
  (setq py-hide-show-minor-mode-p t)
  (setq py-highlight-error-source-p t)))
