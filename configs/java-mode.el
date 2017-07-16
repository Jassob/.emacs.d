;;; ============================================================================
;;; Config file for programming in Java in Emacs.
;;;
;;; Author: Jassob
;;; ============================================================================

;; Fix indentation to 4 spaces, always
(add-hook 'java-mode-hook
          (lambda ()
            (setq-local c-basic-offset 4)
            (setq-local tab-width 4)
            (setq-local indent-tabs-mode nil)))

(add-hook 'java-mode-hook 'company-mode)
