;;; ============================================================================
;;; Configuration file for helm.
;;; ----------------------------
;;;
;;; Keybindings are copied from [helm-maintainer's config](https://github.com/thierryvolpiatto/emacs-tv-config/blob/master/init-helm-thierry.el)
;;;
;;; Author: Jassob
;;; ============================================================================
(use-package helm
  :ensure t
  :bind (:map helm-map 
	      ("<tab>" . helm-execute-persistent-action))
  :bind (:map helm-map
	      ("C-i" . helm-execute-persistent-action))
  :bind ("M-x" . helm-M-x)
  :bind ("C-x C-f" . helm-find-files)
  :bind ("C-x b" . helm-buffers-list)
  :bind ("M-y" .  helm-show-kill-ring)
  :bind ("C-x C-f" . helm-find-files)
  :bind ("C-c <SPC>" . helm-all-mark-rings)
  :bind ("C-x r b" . helm-filtered-bookmarks)
  :bind ("C-h r" . helm-info-emacs)
  :bind ("C-:" . helm-eval-expression-with-eldoc)
  :bind ("C-," . helm-calcul-expression)
  :bind ("C-h i" . helm-info-at-point)
  :bind ("C-x C-d" . helm-browse-project)
  :bind ("C-h C-f" . helm-apropos)
  :bind ("C-h a" . helm-apropos)
  :bind ("C-c i" . helm-imenu-in-all-buffers)
  :bind ("M-g a" . helm-do-grep-ag)
  :bind ("M-g g" . helm-grep-do-git-grep)
  :bind ("M-g i" . helm-gid)

  :init
  (global-set-key (kbd "C-c h") 'helm-command-prefix)
  (global-unset-key (kbd "C-x c"))
  
  :config
  (setq helm-M-x-fuzzy-match t)

  (when (executable-find "curl")
    (setq helm-google-suggest-use-curl-p t))

  (setq helm-split-window-in-side-p           t
	;; open helm buffer inside current window, not occupy whole other window
	helm-move-to-line-cycle-in-source     t
	;; move to end or start of source when reaching top or bottom of source.
	helm-ff-search-library-in-sexp        t
	;; search for library in `require' and `declare-function' sexp.
	helm-scroll-amount                    8
	;; scroll 8 lines other window using M-<next>/M-<prior>
	helm-ff-file-name-history-use-recentf t))

(use-package helm-config
  :bind (:map helm-map
	      ("C-z" . helm-select-action))
  :config
  (progn
    (helm-mode t)
    (helm-adaptive-mode t)
    (helm-push-mark-mode t)))
