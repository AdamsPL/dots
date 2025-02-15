;; -*- lexical-binding:t -*-

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

(straight-use-package 'use-package)
(setq straight-vc-git-default-clone-depth 1)
(setq straight-use-package-by-default t)

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
(winner-mode)

(use-package emacs
  :hook
  (prog-mode . display-line-numbers-mode)
  (prog-mode . electric-pair-mode))

(use-package eglot
  :hook
  (python-mode . eglot-ensure))

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
  :ensure t
  :init
  (setq evil-want-integration t)
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

(use-package helpful
  :config
  (global-set-key (kbd "C-h f") #'helpful-callable)
  (global-set-key (kbd "C-h v") #'helpful-variable)
  (global-set-key (kbd "C-h k") #'helpful-key)
  (global-set-key (kbd "C-h x") #'helpful-command)
  (global-set-key (kbd "C-c C-d") #'helpful-at-point)
  (global-set-key (kbd "C-h F") #'helpful-function))

(use-package sideline-lsp)
(use-package sideline-flymake)
(use-package sideline
  :hook (flymake-mode . sideline-mode)
  :init
  (setq sideline-backends-right '((sideline-flymake . up)
                                  (sideline-lsp . down))))
