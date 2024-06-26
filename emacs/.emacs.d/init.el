;; -*- lexical-binding: t; -*-

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(use-package straight
  :config
  (setq straight-use-package-by-default t)
  (setq straight-vc-git-default-clone-depth 1))

(use-package modus-themes
  :demand t
  :config
  (setq modus-themes-common-palette-overrides
        '((border-mode-line-active unspecified)
          (border-mode-line-inactive unspecified)))
  (load-theme 'modus-vivendi t))

 (use-package mood-line
   :config
   (setq mood-line-glyph-alist mood-line-glyphs-fira-code)
   (mood-line-mode 1))

(use-package use-package
  :init
 (setq use-package-always-ensure t))

(use-package treesit-auto
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))

(use-package lsp-mode
  :hook (prog-mode . lsp)
  :config (setq lsp-warn-no-matched-clients nil))

(use-package lsp-ui)

(use-package flycheck)

(use-package company
  :hook (prog-mode . company-mode))

(use-package yasnippet
  :config (yas-global-mode))

(use-package dape)

(use-package geiser-guile)

(use-package haskell-mode)

(use-package emacs
  :hook
  (prog-mode . display-line-numbers-mode)
  (prog-mode . hl-line-mode)
  (prog-mode . electric-pair-mode)
  :config
  (recentf-mode 1)
  (global-auto-revert-mode)
  (repeat-mode)
  (setq-default tab-width 4)
  (setq-default indent-tabs-mode nil)
  (setq use-short-answers t)
  (setq completion-styles '(basic substring flex))
  (setq eldoc-echo-area-use-multiline-p nil)
  (setq read-extended-command-predicate #'command-completion-default-include-p)
  (setq vc-follow-symlinks t)
  (set-display-table-slot standard-display-table 5 ?│)
  (toggle-frame-maximized))

(use-package magit)

(use-package eat
  :hook
  (eshell-load . eat-eshell-mode))

(use-package org
  :config
  (setq org-hide-emphasis-markers t
        org-pretty-entities t))

(use-package org-bullets
  :hook (org-mode org-bullets-mode))

(use-package evil
 :config
 (evil-set-undo-system 'undo-redo)
 (setq evil-default-state 'emacs)
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
