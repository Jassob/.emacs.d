;;; ============================================================================
;;; Configuration for multiple-cursors.
;;; -----------------------------------
;;;
;;; Authors: Jasso
;;; ============================================================================

(use-package multiple-cursors
  :ensure t
  :init
  ;; C-S-c C-S-c to edit block
  (global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
  ;; C-> for the next word
  (global-set-key (kbd "C->") 'mc/mark-next-like-this)
  ;; C-< for the previous
  (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
  ;; C-c C-> for all words
  (global-set-key (kbd "C-c C->") 'mc/mark-all-like-this))

