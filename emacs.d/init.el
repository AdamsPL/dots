;;; -*- lexical-binding: t -*-

(require 'package)
(require 'use-package)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(setq use-package-always-ensure t)
(setq package-install-upgrade-built-in 't)
(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)
(setq visible-bell nil)
(setq ring-bell-function 'ignore)
(prefer-coding-system       'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))
(add-hook 'dired-mode-hook #'dired-hide-details-mode)

;(set-frame-font "DMMono Nerd Font-10:style=regular")

(menu-bar-mode 0)
(tool-bar-mode 0)
;(scroll-bar-mode 0)
(winner-mode 1)
(repeat-mode 1)
(electric-pair-mode 1)
(recentf-mode 1)
(which-key-mode 1)
(xterm-mouse-mode)
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

(use-package ef-themes
  :config (ef-themes-select 'ef-night))
(use-package evil
  :init (setq evil-undo-system 'undo-redo)
  :config (evil-mode))
(use-package marginalia
  :config (marginalia-mode))
(use-package vertico
  :config (vertico-mode))
(use-package treesit-auto
  :config (global-treesit-auto-mode))
(use-package magit)
(use-package vundo)
(use-package eglot
  :hook (prog-mode . eglot-ensure))
(use-package company
  :config (global-company-mode 1))
(use-package nerd-icons
  :config (setq nerd-icons-font-family "DMMono Nerd Font"))
(use-package nerd-icons-dired
  :hook (dired-mode . nerd-icons-dired-mode))
(use-package nerd-icons-completion
  :after marginalia
  :config
  (nerd-icons-completion-mode)
  (add-hook 'marginalia-mode-hook #'nerd-icons-completion-marginalia-setup))
(use-package simple-modeline
  :hook (after-init . simple-modeline-mode))
(use-package eat)

(setq custom-file (concat user-emacs-directory "extra/custom.el"))
(let ((extra-files (directory-files-recursively (concat user-emacs-directory "/extra") ".el")))
  (dolist (file extra-files)
    (load-file file)))
