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
(toggle-frame-maximized)
(load custom-file)

(recentf-mode 1)
(global-auto-revert-mode)
(repeat-mode)

(use-package compile-angel
  :ensure t
  :demand t
  :custom
  (compile-angel-verbose nil)
  :config
  (compile-angel-on-load-mode)
  (add-hook 'emacs-lisp-mode-hook #'compile-angel-on-save-local-mode))

(use-package emacs
  :hook
  (prog-mode . display-line-numbers-mode)
  (prog-mode . electric-pair-mode))

(use-package use-package
  :init
 (setq use-package-always-ensure t))

(use-package ef-themes
  :config (load-theme 'ef-night t))

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

(use-package evil
 :config
 (setq evil-default-state 'emacs)
 (evil-set-undo-system 'undo-redo)
 (evil-set-initial-state 'prog-mode 'normal)
 )

(defmacro map-evil-ts-obj (key node)
  `(progn
     (define-key evil-inner-text-objects-map ,key (evil-textobj-tree-sitter-get-textobj ,(concat node ".inner")))
     (define-key evil-outer-text-objects-map ,key (evil-textobj-tree-sitter-get-textobj ,(concat node ".outer")))))

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

(use-package eglot
  :hook (python-ts-mode . eglot-ensure)
  (c-ts-mode . eglot-ensure)
  (haskell-mode . eglot-ensure)
  (python-ts-mode . eglot-ensure)
  :config (setq eglot-report-progress nil))

(use-package consult)

(use-package mood-line
  :config
  (mood-line-mode))

(use-package spacious-padding
  :config
  (setq spacious-padding-subtle-mode-line
      `( :mode-line-active 'default
         :mode-line-inactive vertical-border))
  (spacious-padding-mode))

(use-package git-gutter
  :config (global-git-gutter-mode +1))

(use-package meow
  :config
  (setq meow-cheatsheet-layout meow-cheatsheet-layout-qwerty)
  (meow-motion-overwrite-define-key
   '("j" . meow-next)
   '("k" . meow-prev)
   '("<escape>" . ignore))
  (meow-leader-define-key
   ;; SPC j/k will run the original command in MOTION state.
   '("j" . "H-j")
   '("k" . "H-k")
   ;; Use SPC (0-9) for digit arguments.
   '("1" . meow-digit-argument)
   '("2" . meow-digit-argument)
   '("3" . meow-digit-argument)
   '("4" . meow-digit-argument)
   '("5" . meow-digit-argument)
   '("6" . meow-digit-argument)
   '("7" . meow-digit-argument)
   '("8" . meow-digit-argument)
   '("9" . meow-digit-argument)
   '("0" . meow-digit-argument)
   '("/" . meow-keypad-describe-key)
   '("?" . meow-cheatsheet))
  (meow-normal-define-key
   '("0" . meow-expand-0)
   '("9" . meow-expand-9)
   '("8" . meow-expand-8)
   '("7" . meow-expand-7)
   '("6" . meow-expand-6)
   '("5" . meow-expand-5)
   '("4" . meow-expand-4)
   '("3" . meow-expand-3)
   '("2" . meow-expand-2)
   '("1" . meow-expand-1)
   '("-" . negative-argument)
   '(";" . meow-reverse)
   '("," . meow-inner-of-thing)
   '("." . meow-bounds-of-thing)
   '("[" . meow-beginning-of-thing)
   '("]" . meow-end-of-thing)
   '("a" . meow-append)
   '("A" . meow-open-below)
   '("b" . meow-back-symbol)
   '("B" . meow-back-word)
   '("c" . meow-change)
   '("d" . meow-delete)
   '("D" . meow-backward-delete)
   '("e" . meow-next-symbol)
   '("E" . meow-next-word)
   '("f" . meow-find)
   '("g" . meow-cancel-selection)
   '("G" . meow-grab)
   '("h" . meow-left)
   '("H" . meow-left-expand)
   '("i" . meow-insert)
   '("I" . meow-open-above)
   '("j" . meow-next)
   '("J" . meow-next-expand)
   '("k" . meow-prev)
   '("K" . meow-prev-expand)
   '("l" . meow-right)
   '("L" . meow-right-expand)
   '("m" . meow-join)
   '("n" . meow-search)
   '("o" . meow-block)
   '("O" . meow-to-block)
   '("p" . meow-yank)
   '("q" . meow-goto-line)
   '("Q" . kill-whole-line)
   '("r" . meow-replace)
   '("R" . meow-swap-grab)
   '("s" . meow-kill)
   '("t" . meow-till)
   '("T" . transpose-lines)
   '("u" . undo-tree-undo)
   '("U" . undo-tree-redo)
   '("v" . meow-line)
   '("W" . meow-mark-word)
   '("w" . meow-mark-symbol)
   '("V" . meow-visit)
   '("y" . meow-save)
   '("Y" . meow-sync-grab)
   '("z" . meow-pop-selection)
   '("'" . repeat)
   '("<escape>" . ignore)
   '("\\" . find-file)
   '("|" . recentf)
   '("/" . isearch-forward-regexp)
   '("?" . isearch-backward-regexp)
   '("TAB" . switch-to-buffer))
  (setq meow-expand-hint-remove-delay 0)
  (meow-global-mode +1))

(use-package meow-tree-sitter
  :after meow
  :config
  (meow-tree-sitter-register-defaults))

(use-package undo-tree
  :config (global-undo-tree-mode +1))

