;; -*- lexical-binding:t -*-
(menu-bar-mode 0)
(when (display-graphic-p)
  (tool-bar-mode 0)
  (scroll-bar-mode 0)
  (set-face-attribute 'default nil :font "Inconsolata Nerd Font Mono" :height 110))
  (toggle-frame-maximized)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(require 'use-package)
(setq use-package-always-ensure t)

(setq native-comp-async-query-on-exit t)
(setq confirm-kill-processes t)
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)
(setq use-short-answers t)
(setq completion-styles '(basic substring flex))
(setq read-extended-command-predicate #'command-completion-default-include-p)
(setq vc-follow-symlinks t)
(setq major-mode-remap-alist
      '((python-mode . python-ts-mode)
        (c-mode . c-ts-mode)
        (c++-mode . c++-ts-mode)
        (bash-mode . bash-ts-mode)
        (rust-mode . rust-ts-mode)))
(setq isearch-wrap-pause 'no)
(setq split-height-threshold 200)
(setq isearch-lazy-count t)
(setq tab-bar-tab-hints t)

(load custom-file)
(recentf-mode 1)
(global-auto-revert-mode)
(global-visual-line-mode t)
(repeat-mode)
(winner-mode)

(use-package emacs
  :hook
  (prog-mode . display-line-numbers-mode)
  (prog-mode . electric-pair-mode))

(use-package eglot
  :hook
  (python-ts-mode . eglot-ensure))

(use-package company
  :config
  (global-company-mode t))

(use-package eat
  :hook
  (eshell-load . eat-eshell-mode))

(use-package org
  :config
  (setq org-hide-emphasis-markers t
        org-pretty-entities t
        org-confirm-babel-evaluate nil)
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((python . t))))

(use-package savehist
  :config (savehist-mode))

(use-package vertico
  :config
  (keymap-set vertico-map "C-j" #'vertico-exit-input)
  (vertico-mode))

(use-package marginalia
  :config (marginalia-mode 1))

(use-package which-key
  :config (which-key-mode))

(use-package yasnippet
  :config
  (yas-global-mode))
(use-package yasnippet-snippets)

(use-package magit)

(use-package diff-hl
  :config
  (diff-hl-margin-mode)
  (global-diff-hl-mode))

(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-undo-system 'undo-tree)
  (setq evil-search-module 'isearch)
  :config
  (evil-set-leader '(normal visual) (kbd "SPC"))
  (evil-define-key nil 'global (kbd "<leader>c") 'evil-commentary-line)
  (evil-define-key nil 'global (kbd "<leader>q") 'flymake-show-buffer-diagnostics)
  (evil-define-key nil 'global (kbd "<leader>v") 'eval-region)
  (evil-define-key nil 'global (kbd "<leader>1") (lambda () (interactive) (tab-select 1)))
  (evil-define-key nil 'global (kbd "<leader>2") (lambda () (interactive) (tab-select 2)))
  (evil-define-key nil 'global (kbd "<leader>3") (lambda () (interactive) (tab-select 3)))
  (evil-define-key nil 'global (kbd "<leader>4") (lambda () (interactive) (tab-select 4)))
  (evil-define-key nil 'global (kbd "<leader>5") (lambda () (interactive) (tab-select 5)))
  (evil-define-key nil 'global (kbd "<leader>6") (lambda () (interactive) (tab-select 6)))
  (evil-define-key nil 'global (kbd "<leader>7") (lambda () (interactive) (tab-select 7)))
  (evil-define-key nil 'global (kbd "<leader>8") (lambda () (interactive) (tab-select 8)))
  (evil-define-key nil 'global (kbd "<leader>9") (lambda () (interactive) (tab-select 9)))
  (evil-define-key nil 'global (kbd "M-j") 'evil-collection-unimpaired-move-text-down)
  (evil-define-key nil 'global (kbd "M-k") 'evil-collection-unimpaired-move-text-up)
  (evil-mode 1))
(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))
(use-package evil-surround
  :config
  (global-evil-surround-mode 1))
(use-package evil-commentary
  :config
  (evil-commentary-mode +1))
(use-package evil-textobj-tree-sitter)

(use-package undo-tree
  :config
  (setq undo-tree-history-directory-alist '(("." . "/tmp/emacs/undo")))
  (global-undo-tree-mode +1))

(use-package nerd-icons)
(use-package nerd-icons-dired
  :hook
  (dired-mode . nerd-icons-dired-mode))

(use-package nerd-icons-completion
  :after marginalia
  :config
  (nerd-icons-completion-mode)
  (add-hook 'marginalia-mode-hook #'nerd-icons-completion-marginalia-setup))

(use-package doom-themes
  :config
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-tokyo-night t)
  (doom-themes-neotree-config)
  (doom-themes-org-config))

(use-package doom-modeline
  :config
  (setq doom-modeline-height 1)
  (doom-modeline-mode 1))

(use-package ediff
  :config
  (setq ediff-keep-variants nil
        ediff-split-window-function 'split-window-horizontally
        ediff-window-setup-function 'ediff-setup-windows-plain))

(use-package sideline-flymake)
(use-package sideline
  :hook (flymake-mode . sideline-mode)
  :init
  (setq sideline-backends-right '(sideline-flymake)))

(use-package haskell-mode)
