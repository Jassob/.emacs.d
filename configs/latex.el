;;; ============================================================================
;;; Configuration file for typesetting LaTeX documents in Emacs
;;;
;;; Author: Jassob
;;; ============================================================================

(use-package tex-site
  :ensure auctex
  :bind ("C-c o" . helm-imenu)
  :config
  (add-hook 'latex-mode-hook 'reftex-mode-hook)
  (add-hook 'reftex-load-hook 'imenu-add-menubar-index)
  (add-hook 'reftex-mode-hook 'imenu-add-menubar-index)
  )

(defun flymake-get-tex-args (file-name)
  (list "pdflatex" (list
                    "-file-line-error"
                    "-draftmode"
                    "-interaction=nonstopmode"
                    file-name)))

(defun latex-word-count ()
  (interactive)
  (shell-command (concat user-emacs-directory
                         "include/texcount.pl "
                         "-inc "
                         (buffer-file-name))))
