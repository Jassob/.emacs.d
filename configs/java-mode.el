;;; ============================================================================
;;; Config file for programming in Java in Emacs.
;;;
;;; Author: Jassob
;;; ============================================================================
;; Fix indentation to 4 spaces, always
(add-hook 'java-mode-hook
          (lambda ()
            (setq c-basic-offset 4
                  tab-width 4
                  indent-tabs-mode nil)))

(add-hook 'java-mode-hook 'hs-minor-mode)
(add-hook 'java-mode-hook 'company-mode)
(add-hook 'java-mode-hook 'flymake-mode)


