;;; ============================================================================
;;; Configuration file of modes used in haskell programming.
;;; ------------------------------------------------------------
;;;
;;; Author: Jassob
;;; ============================================================================
(use-package haskell-mode
  :config

  ;; Load company on auto-load
  (use-package company
    :config
    (add-to-list 'company-backends 'company-ghc)
    (add-hook 'haskell-mode-hook 'company-mode)
    (add-hook 'haskell-mode-hook 'haskell-indentation-mode))

  ;; Load haskell interactive mode on auto-load
  (use-package haskell-interactive-mode
    :config
    (add-hook 'haskell-mode-hook 'interactive-haskell-mode)))
