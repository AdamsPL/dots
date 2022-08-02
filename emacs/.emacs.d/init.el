;;; Package --- Summary
;;; Commentary:
;;; Code:

(setq package-enable-at-startup nil)

(setq inhibit-startup-screen t)
(menu-bar-mode -1)
(when (display-graphic-p)
    (tool-bar-mode -1)
    (toggle-scroll-bar -1))
(require 'mouse)
(xterm-mouse-mode t)

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

(straight-use-package 'marginalia)
(marginalia-mode)

(straight-use-package 'vertico)
(straight-use-package 'prescient)
(vertico-mode +1)

(straight-use-package 'consult)
(recentf-mode +1)
(straight-use-package 'embark)
(straight-use-package 'embark-consult)
(add-hook 'embark-collect-mode 'consult-preview-at-point-mode)

(straight-use-package 'company)
(global-company-mode)

(straight-use-package 'haskell-mode)
(straight-use-package 'yasnippet)
(straight-use-package 'yasnippet-snippets)
(yas-global-mode +1)

(straight-use-package 'eglot)
(add-hook 'c-mode-hook 'eglot-ensure)
(add-hook 'c++-mode-hook 'eglot-ensure)
(add-hook 'haskell-mode-hook 'eglot-ensure)
(add-hook 'python-mode-hook 'eglot-ensure)
(add-hook 'bash-mode-hook 'eglot-ensure)

(straight-use-package 'magit)
(straight-use-package 'git-gutter)
(global-git-gutter-mode)
(straight-use-package 'git-timemachine)

(straight-use-package 'markdown-mode)
(straight-use-package 'rainbow-mode)

(straight-use-package 'evil)
(straight-use-package 'evil-collection)
(setq evil-want-keybinding nil)
(setq evil-want-integration t)
(setq evil-undo-system 'undo-tree)
(evil-mode t)
(evil-collection-init)

(evil-set-leader 'normal (kbd "\\"))
(evil-global-set-key 'normal (kbd "g e") 'eglot-find-declaration)
(evil-global-set-key 'normal (kbd "g d") 'xref-find-definitions)
(evil-global-set-key 'normal (kbd "g r") 'xref-find-references)
(evil-global-set-key 'normal (kbd "g i") 'eglot-find-implementation)
(evil-global-set-key 'normal (kbd "g t") 'eglot-find-typeDefinition)
(evil-global-set-key 'normal (kbd "g c") (lambda () (interactive) (find-file "~/.emacs.d/init.el")))
(evil-global-set-key 'normal (kbd "g o") (lambda () (interactive) (find-file "~/docs/todo.org")))
(evil-global-set-key 'normal (kbd "<leader> e") 'consult-flymake)
(evil-global-set-key 'normal (kbd "<leader> b") 'consult-buffer)

(provide 'init)
