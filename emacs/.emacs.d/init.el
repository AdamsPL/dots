;;; Package --- Summary
;;; Commentary:
;;; Code:

(setq package-enable-at-startup nil)

; LOOK AND FEEL
(setq inhibit-startup-screen t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(toggle-scroll-bar -1)
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode)
(setq backup-directory-alist '(("." . "~/.emacs/backup/")))

(add-to-list 'default-frame-alist '(font . "UbuntuMono Nerd Font-12"))
(add-to-list 'default-frame-alist '(mouse-color . "white"))
(setq custom-file (concat user-emacs-directory "/custom.el"))
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))
(setq indent-tabs-mode nil)

; PACKAGE MANAGER
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
	(url-retrieve-synchronously
	 "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
	 'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))
 
(straight-use-package 'base16-theme)
(setq base16-theme-256-color-source 'colors)
(load-theme 'base16-chalk t)

(straight-use-package 'doom-modeline)
(doom-modeline-mode 1)

(straight-use-package 'undo-tree)
(setq undo-tree-visualizer-diff t)
(setq undo-tree-history-directory-alist '(("." . "~/.emacs.d/undo/")))
(setq undo-tree-visualizer-timestamps t)
(global-undo-tree-mode)

(straight-use-package 'evil)
(setq evil-want-keybinding nil)
(setq evil-undo-system 'undo-tree)
(evil-mode t)

:(straight-use-package 'evil-collection)
(evil-collection-init)

(straight-use-package 'marginalia)
(marginalia-mode)
(straight-use-package 'ctrlf)
(ctrlf-mode +1)

(straight-use-package 'selectrum)
(straight-use-package 'selectrum-prescient)
(straight-use-package 'prescient)
(selectrum-mode +1)
(selectrum-prescient-mode +1)
(prescient-persist-mode +1)

(straight-use-package 'consult)
(straight-use-package 'consult-lsp)
(recentf-mode +1)

(straight-use-package 'company)
(global-company-mode) 

(straight-use-package 'haskell-mode)
(straight-use-package 'lsp-mode)
(straight-use-package 'lsp-ui)
(setq lsp-lens-enable nil)
(setq lsp-ui-sideline-show-diagnostics 1)
(setq lsp-ui-sideline-show-code-actions 1)
(add-hook 'c-mode-hook 'lsp)
(add-hook 'c++-mode-hook 'lsp)
(add-hook 'haskell-mode-hook 'lsp)
(add-hook 'python-mode-hook 'lsp)

(straight-use-package 'yasnippet)
(yas-global-mode 1)

(straight-use-package 'magit)

(straight-use-package 'git-gutter)
(global-git-gutter-mode)

(straight-use-package 'rainbow-mode)
(rainbow-mode)

(require 'mouse)
(xterm-mouse-mode t)

(provide 'init)
