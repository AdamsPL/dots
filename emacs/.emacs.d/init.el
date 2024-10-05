;; -*- lexical-binding:t -*-

(use-package emacs
  :hook
  (prog-mode . display-line-numbers-mode)
  (prog-mode . electric-pair-mode)
  :config
  (recentf-mode 1)
  (global-auto-revert-mode)
  (repeat-mode)
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
  (setq-default tab-width 4)
  (setq-default indent-tabs-mode nil)
  (setq use-short-answers t)
  (setq completion-styles '(basic substring flex))
  (setq eldoc-echo-area-use-multiline-p nil)
  (setq read-extended-command-predicate #'command-completion-default-include-p)
  (setq vc-follow-symlinks t)
  (setq major-mode-remap-alist
        '((python-mode . python-ts-mode)
          (c-mode . c-ts-mode)
          (c++-mode . c++-ts-mode)
          (bash-mode . bash-ts-mode)
          (rust-mode . rust-ts-mode)))
  (set-display-table-slot standard-display-table 5 ?│)
  (toggle-frame-maximized))

(use-package use-package
  :init
 (setq use-package-always-ensure t))

(use-package ef-themes
  :config (load-theme 'ef-dark t))

(use-package dape)

(use-package company
  :config (global-company-mode t))

(use-package geiser-guile)

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

(use-package evil
 :config
 (setq evil-default-state 'emacs)
 (evil-set-undo-system 'undo-redo)
 (evil-set-initial-state 'prog-mode 'normal)
 (evil-mode 1))

(defmacro map-evil-ts-obj (key node)
  `(progn
     (define-key evil-inner-text-objects-map ,key (evil-textobj-tree-sitter-get-textobj ,(concat node ".inner")))
     (define-key evil-outer-text-objects-map ,key (evil-textobj-tree-sitter-get-textobj ,(concat node ".outer")))))

(use-package evil-textobj-tree-sitter
  :config
  (map-evil-ts-obj "f" "function")
  (map-evil-ts-obj "b" "block")
  (map-evil-ts-obj "c" "conditional")
  (map-evil-ts-obj "C" "comment")
  (map-evil-ts-obj "l" "loop"))

(use-package savehist
  :config (savehist-mode))

(use-package avy
  :bind ("C-;" . 'avy-goto-char-timer))

(use-package ace-window
  :bind ("M-o" . 'ace-window))

(use-package vertico
  :config
  (vertico-mode))

(use-package marginalia
  :config (marginalia-mode 1))

(use-package projectile
  :config
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (projectile-mode +1))

(use-package which-key
  :config (which-key-mode))

(use-package yasnippet)

(use-package eglot
  :hook (python-ts-mode . eglot-ensure)
  (c-ts-mode . eglot-ensure)
  (haskell-mode . eglot-ensure)
  :config (setq eglot-report-progress nil))
