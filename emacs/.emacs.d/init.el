;; -*- lexical-binding:t -*-

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(setq package-native-compile t)
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
(toggle-frame-maximized)
(load custom-file)
(recentf-mode 1)
(global-auto-revert-mode)
(global-visual-line-mode t)
(repeat-mode)

(use-package emacs
  :hook
  (prog-mode . display-line-numbers-mode)
  (prog-mode . electric-pair-mode))

(use-package use-package
  :init
 (setq use-package-always-ensure t))

(use-package company
  :config (global-company-mode t))

(use-package haskell-mode)

(use-package magit)

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

(use-package avy
  :bind ("C-;" . 'avy-goto-char-timer))

(use-package ace-window
  :bind ("M-o" . 'ace-window))

(use-package vertico
  :config
  (keymap-set vertico-map "C-j" #'vertico-exit-input)
  (vertico-mode))

(use-package marginalia
  :config (marginalia-mode 1))

(use-package projectile
  :config
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (projectile-mode +1))

(use-package which-key
  :config (which-key-mode))

(use-package yasnippet
  :config
  (yas-global-mode))

(use-package yasnippet-snippets)

(use-package lsp-mode
  :hook (prog-mode . #'lsp-defered)
  )
(use-package lsp-ui :commands lsp-ui-mode)
(use-package lsp-treemacs :commands lsp-treemacs-errors-list)
(use-package flycheck)

;; (use-package eglot
;;   :hook
;;   (python-ts-mode . eglot-ensure))

(use-package mood-line
  :config
  (mood-line-mode))

(use-package spacious-padding
  :config
  ;; (setq spacious-padding-subtle-mode-line
  ;;     `( :mode-line-active 'default
  ;;        :mode-line-inactive vertical-border))
  (spacious-padding-mode))

(use-package git-gutter
  :config (global-git-gutter-mode +1))

(use-package evil
  :ensure t
  :init
  (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
  (setq evil-want-keybinding nil)
  (setq evil-undo-system 'undo-tree)
  :config
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1))

(use-package evil-commentary
  :config
  (evil-commentary-mode +1))

(use-package evil-textobj-tree-sitter)

(use-package treemacs-evil)

(use-package undo-tree
  :config
  (setq undo-tree-history-directory-alist '(("." . "/tmp/emacs/undo")))
  (global-undo-tree-mode +1))

(use-package all-the-icons)

(use-package doom-themes
  :ensure t
  :config
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-tokyo-night t)
  ;(doom-themes-visual-bell-config)
  (doom-themes-neotree-config)
  (setq doom-themes-treemacs-theme "doom-atom")
  (doom-themes-treemacs-config)
  (doom-themes-org-config))
