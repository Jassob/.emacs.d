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
  :bind ("C-c C-s" . magit-status))
