;;; ============================================================================
;;; Configuration file for SLIME with StumpWM
;;;
;;; Source: https://www.emacswiki.org/emacs/StumpWM
;;; ============================================================================

(use-package slime
  :ensure t
  :init
  ;; In my case /path/to/quicklisp is ~/quicklisp
  (defvar quicklisp-path "~/quicklisp")
  (setq inferior-lisp-program "sbcl")
  (setq slime-contrib '(slime-fancy))
  :config
  ;; Load slime-helper, this sets up various autoloads:
  (load (concat quicklisp-path "/slime-helper"))
  ;; Decide where to put a slime scratch file
  (setf slime-scratch-file (concat user-emacs-directory ".slime-scratch.lisp")))
