;;; ============================================================================
;;; Configuration file for ZNC for Emacs
;;;
;;; Author: Jassob
;;; ============================================================================

(use-package znc
  :init
  (setq znc-servers
	(quote
	 (("your-server-name-here" your-port-number-here nil
	   ((network-slug "your-username-here" "your-password-here")))))))
