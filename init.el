(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)


;; Install missing packages requiered for this init.el.
(defvar package-list
  '(use-package color-theme-sanityinc-tomorrow theme-changer))

(dolist (p package-list)
  (unless (package-installed-p p)
    (package-install p)))

;; Configure smex
(use-package smex
  :ensure t
  :demand
  :init
  :bind ("M-x" . smex)
  :config
  (require 'ido)
  (setq ido-enable-flex-matching t
        ido-everywhere t)
  (ido-mode t))

;;; ============================================================================
;;; Keybindings
;;; ============================================================================
(global-set-key (kbd "s-u") 'revert-buffer)

(global-set-key (kbd "<S-s-right>") 'buf-move-right)
(global-set-key (kbd "<S-s-left>") 'buf-move-left)
(global-set-key (kbd "<S-s-up>") 'buf-move-up)
(global-set-key (kbd "<S-s-down>") 'buf-move-down)

(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>") 'shrink-window)
(global-set-key (kbd "S-C-<up>") 'enlarge-window)

(global-set-key (kbd "C-c h") 'windmove-left)
(global-set-key (kbd "C-c l") 'windmove-right)
(global-set-key (kbd "C-c k") 'windmove-up)
(global-set-key (kbd "C-c j") 'windmove-down)

;;; ============================================================================
;;; Hooks
;;; ============================================================================
(defun contextual-menubar (&optional frame)
  "Never show menubar, toolbar or scrollbar in FRAME."
  (interactive)
  (set-frame-parameter frame 'menu-bar-lines 0)
  (set-frame-parameter frame 'tool-bar-lines 0)
  (set-frame-parameter frame 'vertical-scroll-bars nil))

(add-hook 'after-make-frame-functions 'contextual-menubar)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(remove-hook 'kill-buffer-query-functions 'server-kill-buffer-query-function)

;;; ============================================================================
;;; General stuff
;;; ============================================================================
(when (display-graphic-p)
  (menu-bar-mode -1)
  (tool-bar-mode -1)
  (toggle-scroll-bar -1))

;; Display clock in modeline
(display-time)
(column-number-mode)
(blink-cursor-mode 0)

;; Set a bunch of stuff
(setq initial-scratch-message ""
      inhibit-startup-message t

      ;; Disable visual or graphic error bell
      ring-bell-function 'ignore

      ;; Unset right option key as meta
      ns-right-alternate-modifier nil

      ;; don't litter my fs tree (save backups in /tmp)
      backup-directory-alist `((".*" . ,temporary-file-directory))
      auto-save-file-name-transforms `((".*" ,temporary-file-directory t))
      auto-save-list-file-prefix temporary-file-directory
      backup-by-copying t

      ;; Keep at most 4 copies of every file (2 new and then 2 old copies)
      kept-new-versions 2
      kept-old-versions 2
      delete-old-versions t

      ;; use versioned backups
      version-control t)

;; Theming
(defvar calendar-location-name "Gothenburg, SE")
(defvar calendar-latitude 57.71)
(defvar calendar-longitude 11.97)

(require 'theme-changer)
(change-theme 'sanityinc-tomorrow-day 'sanityinc-tomorrow-night)

;; Don't prompt as much
(fset 'yes-or-no 'y-or-n)

;; Use auto indent mode
(electric-indent-mode t)

(global-flycheck-mode -1)

;; Set the $PATH environment variable
(setenv "PATH" (mapconcat 'identity '("/home/jassob/.cabal/bin"
                                      "/home/jassob/.local/bin"
                                      "/usr/local/sbin"
                                      "/usr/local/bin"
                                      "/usr/sbin"
                                      "/usr/bin")
                          ":"))

;; Add cabal and .local bins to exec-path
(setq exec-path (append exec-path '("/home/jassob/.cabal/bin"
                                    "/home/jassob/.local/bin")))

;;; ============================================================================
;;; Agda mode
;;; ============================================================================
(load-file (let ((coding-system-for-read 'utf-8))
             (shell-command-to-string "agda-mode locate")))

;;; ============================================================================
;;; Load separate config files
;;; ============================================================================
(defun load-config (file)
  "Load a Emacs config file FILE from .emacs.d/configs/."
  (load (concat user-emacs-directory "configs/" file)))

(load-config "hs-minor-mode.el")
(load-config "god-mode.el")
(load-config "multiple-cursors.el")
(load-config "org-mode.el")
(load-config "magit-mode.el")
(load-config "haskell.el")
(load-config "python-mode.el")
(load-config "java-mode.el")
(load-config "latex.el")
(load-config "dired.el")
(load-config "pandoc-mode.el")
(load-config "znc.el")
(load-config "fancy-battery-mode.el")
(load-config "emms.el")
(load-config "eww.el")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(battery-mode-line-format "  %p, %t")
 '(browse-url-browser-function (quote eww-browse-url))
 '(compilation-message-face (quote default))
 '(cua-global-mark-cursor-color "#2aa198")
 '(cua-normal-cursor-color "#657b83")
 '(cua-overwrite-cursor-color "#b58900")
 '(cua-read-only-cursor-color "#859900")
 '(custom-safe-themes
   (quote
    ("6bde11b304427c7821b72a06a60e8d079b8f7ae10b407d8af37ed5e5d59b1324" "c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "5e2dc1360a92bb73dafa11c46ba0f30fa5f49df887a8ede4e3533c3ab6270e08" default)))
 '(display-battery-mode t)
 '(display-time-24hr-format t)
 '(display-time-day-and-date nil)
 '(display-time-default-load-average nil)
 '(display-time-mode t)
 '(doc-view-resolution 227)
 '(ede-project-directories (quote ("/home/jassob/Skola/AFP/labs/assignment2")))
 '(erc-notifications-mode t)
 '(fancy-battery-mode nil)
 '(fci-rule-character-color "#192028")
 '(haskell-tags-on-save t)
 '(hindent-style "chris-done")
 '(hl-bg-colors
   (quote
    ("#DEB542" "#F2804F" "#FF6E64" "#F771AC" "#9EA0E5" "#69B7F0" "#69CABF" "#B4C342")))
 '(hl-fg-colors
   (quote
    ("#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3")))
 '(indent-tabs-mode nil)
 '(jdee-db-active-breakpoint-face-colors (cons "#0d0f11" "#41728e"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#0d0f11" "#b5bd68"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#0d0f11" "#5a5b5a"))
 '(latex-run-command "xelatex")
 '(magit-diff-use-overlays nil)
 '(nrepl-message-colors
   (quote
    ("#dc322f" "#cb4b16" "#b58900" "#546E00" "#B4C342" "#00629D" "#2aa198" "#d33682" "#6c71c4")))
 '(org-agenda-files
   (quote
    ("~/.todo/reading.org" "~/.todo/todo.org" "~/.todo/chalmers.org")))
 '(org-clock-into-drawer "LOGBOOK")
 '(org-default-notes-file "~/.todo/todo.org")
 '(org-ellipsis "  ")
 '(org-export-backends (quote (ascii html icalendar latex md odt)))
 '(org-fontify-done-headline t)
 '(org-fontify-quote-and-verse-blocks t)
 '(org-fontify-whole-heading-line t)
 '(org-icalendar-include-todo t)
 '(org-journal-dir "~/.emacs.d/journal/")
 '(org-log-into-drawer t)
 '(org-modules
   (quote
    (org-bbdb org-bibtex org-ctags org-docview org-eww org-gnus org-habit org-info org-irc org-protocol org-rmail org-w3m)))
 '(org-trello-current-prefix-keybinding "C-c o" nil (org-trello))
 '(package-selected-packages
   (quote
    (projectile dante w3m omnisharp benchmark-init org-pomodoro php-refactor-mode apache-mode phpunit php-mode fireplace language-detection spaceline magithub buffer-move orgit w3 top-mode edit-server-htmlize edit-server org-journal htmlize mmm-mode theme-changer smart-mode-line evil-numbers org pandoc bnfc smex vimrc-mode matlab-mode znc weechat-alert web-mode use-package twilight-theme twilight-bright-theme twilight-anti-bright-theme spotify restclient rainbow-mode rainbow-delimiters python-mode php+-mode pdf-tools paredit pandoc-mode org-trello nginx-mode multiple-cursors markdown-mode+ magit latex-preview-pane json-mode js3-mode js-comint jade-mode intero hindent helm god-mode github-notifier github-issues git-gutter+ gist flymake-python-pyflakes fancy-battery exwm evil erlang emojify emms-player-mpv eimp company-ghci company-ghc company-auctex column-marker color-theme-sanityinc-tomorrow color-theme-approximate base16-theme auctex-lua auctex-latexmk)))
 '(pdf-latex-command "xelatex")
 '(pdf-view-continuous nil)
 '(pos-tip-background-color "#eee8d5")
 '(pos-tip-foreground-color "#586e75")
 '(preview-default-option-list
   (quote
    ("displaymath" "floats" "graphics" "textmath" "sections" "footnotes" "showlabels" "psfixbb" "table" "tabular")))
 '(recentf-mode t)
 '(reftex-plug-into-AUCTeX t)
 '(safe-local-variable-values
   (quote
    ((haskell-process-type . ghci)
     (mmm-classes . literate-haskell-latex)
     (TeX-command-extra-option . -shell-escape)
     (TeX-engine . xelatex)
     (TeX-command-extra-options . -shell-escape))))
 '(send-mail-function (quote smtpmail-send-it))
 '(shell-escape-mode "-shell-escape")
 '(smartrep-mode-line-active-bg (solarized-color-blend "#859900" "#eee8d5" 0.2))
 '(sml/battery-format " %p")
 '(sml/shorten-modes t)
 '(sml/show-file-name t)
 '(sml/theme (quote respectful))
 '(smtpmail-smtp-server "smtp.gmail.com")
 '(smtpmail-smtp-service 25 t)
 '(tex-run-command "xelatex")
 '(winner-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(sml/charging ((t (:inherit sml/global :foreground "gold"))))
 '(sml/discharging ((t (:inherit sml/global :foreground "orange red")))))
