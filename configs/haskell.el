;;; ============================================================================
;;; Configuration file of modes used in haskell programming.
;;; ------------------------------------------------------------
;;;
;;; Author: Jassob
;;; ============================================================================
(use-package haskell-mode
  :ensure t
  :config
  (add-hook 'haskell-mode-hook 'interactive-haskell-mode)

  ;; Load company on auto-load
  (use-package company
    :ensure t
    :config
    (add-to-list 'company-backends 'company-ghc)
    (add-hook 'haskell-mode-hook 'company-mode)
    (add-hook 'haskell-mode-hook 'haskell-indentation-mode))

  ;; Load haskell interactive mode on auto-load
  (use-package haskell-interactive-mode))
