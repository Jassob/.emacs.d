;;; ============================================================================
;;; Configuration file of modes used in haskell programming.
;;; ------------------------------------------------------------
;;;
;;; Author: Jassob
;;; With some stolen parts from adamse,
;;;    Source: https://github.com/adamse/emacs.d/blob/master/config/haskell.el
;;; ============================================================================

(defun haskell-insert-undefined ()
  "Insert undefined."
  (interactive)
  (if (and (boundp 'structured-haskell-mode)
           structured-haskell-mode)
      (shm-insert-string "undefined")
    (insert "undefined")))

(use-package haskell-mode
  :ensure t
  :mode "\\.hs$"
  :mode ("\\.ghci$" . ghci-script-mode)
  :mode ("\\.cabal$" . haskell-cabal-mode)
  :interpreter (("runghc" . haskell-mode)
                ("runhaskell" . haskell-mode))
  :bind
  (:map haskell-mode-map
	("C-`" . haskell-interactive-bring)
	("C-c C-t" . haskell-process-do-type)
	("C-c c" . haskell-process-cabal)
	("C-c C-c" . haskell-process-cabal-build)
	("C-c C-u" . haskell-insert-undefined)
	("C-c C-a" . haskell-insert-doc))

  :config
  (add-hook 'haskell-mode-hook 'haskell-auto-insert-module-template)
  (add-hook 'haskell-mode-hook 'git-gutter+-mode))

(use-package company-ghc
  :after haskell-mode
  :ensure t
  :config
  (add-to-list 'company-backends 'company-ghc)
  (setq company-ghc-show-info 'oneline)
  (if (executable-find "ghc-mod")
      (add-hook 'haskell-mode-hook #'ghc-comp-init)
    (warn "haskell-mode: couldn't find ghc-mod")))

(use-package dante
  :after haskell-mode
  :ensure t
  :config
  (if (executable-find "cabal")
      (add-hook! 'haskell-mode-hook
        #'(flycheck-mode dante-mode interactive-haskell-mode))
    (warn "haskell-mode: couldn't find cabal"))

  (add-hook 'dante-mode-hook
            '(lambda () (flycheck-add-next-checker 'haskell-dante
                                                   '(warning . haskell-hlint)))))
