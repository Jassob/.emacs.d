;;; ============================================================================
;;; Configuration file for pandoc-mode
;;;
;;; This mode is intended for interacting with files that later will be
;;: converted via pandoc to some format.
;;; ============================================================================

(use-package pandoc-mode
  :ensure t
  :init
  (add-hook 'markdown-mode-hook 'pandoc-mode))
