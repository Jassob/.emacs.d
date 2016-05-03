;;; ============================================================================
;;; Configuration file for Magit.
;;; -----------------------------
;;;
;;; Author: Jassob
;;; ============================================================================

;;; Bind C-c C-S to magit status
(use-package magit
  :ensure t
  :init
  :bind ("C-c C-s" . magit-status)
  :config

  (use-package git-gutter+
    :ensure t
    :config
    ;; Add hooks
    (add-hook 'ruby-mode-hook 'git-gutter+-mode)
    (add-hook 'haskell-mode-hook 'git-gutter+-mode)
    (add-hook 'latex-mode-hook 'git-gutter+-mode)
    (add-hook 'python-mode-hook 'git-gutter+-mode)
    (add-hook 'c-mode-hook 'git-gutter+-mode)
    (add-hook 'lisp-mode-hook 'git-gutter+-mode)
    (add-hook 'elisp-mode-hook 'git-gutter+-mode)
    (add-hook 'javascript-mode-hook 'git-gutter+-mode)

    ;; Add keybindings
    ;;; Jump between hunks
    (define-key git-gutter+-mode-map (kbd "C-x n") 'git-gutter+-next-hunk)
    (define-key git-gutter+-mode-map (kbd "C-x p") 'git-gutter+-previous-hunk)
    ;;; Act on hunks
    (define-key git-gutter+-mode-map (kbd "C-x v =") 'git-gutter+-show-hunk)
    (define-key git-gutter+-mode-map (kbd "C-x r") 'git-gutter+-revert-hunks)
    ;; Stage hunk at point.
    ;; If region is active, stage all hunk lines within the region.
    (define-key git-gutter+-mode-map (kbd "C-x t") 'git-gutter+-stage-hunks)
    (define-key git-gutter+-mode-map (kbd "C-x c") 'git-gutter+-commit)
    (define-key git-gutter+-mode-map (kbd "C-x C") 'git-gutter+-stage-and-commit)
    (define-key git-gutter+-mode-map (kbd "C-x C-y") 'git-gutter+-stage-and-commit-whole-buffer)
    (define-key git-gutter+-mode-map (kbd "C-x U") 'git-gutter+-unstage-whole-buffer)))
