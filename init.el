(require 'package)
(require 'use-package)

(setq make-backup-files nil)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(setq use-package-always-ensure t)

(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(winner-mode 1)
(repeat-mode 1)

(load-theme 'modus-vivendi)

(use-package evil
  :config (evil-mode))
(use-package vertico
  :config (vertico-mode))
(use-package company
  :config (global-company-mode 1))
(use-package treesit-auto
  :custom
  (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))
(use-package magit)

(setq custom-file (concat user-emacs-directory "custom.el"))
(when (file-exists-p custom-file)
  (load custom-file))
