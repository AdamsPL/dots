;; -*- lexical-binding:t -*-

(setq gc-cons-threshold (* 32 1024 1024))

(setq custom-file "~/.emacs.d/custom.el")
(setq create-lockfiles nil)
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))
(setq backup-by-copying t)
(setq delete-old-versions t)
(setq kept-new-versions 8)
(setq kept-old-versions 2)
(setq version-control t)
(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/backups" t)))

(setq inhibit-startup-message t)
(setq initial-scratch-message nil)
(setq initial-major-mode 'fundamental-mode)
(setq warning-minimum-level :error)

(set-face-attribute 'default nil :height 120)
(menu-bar-mode 0)
(when window-system
  (tool-bar-mode 0)
  (scroll-bar-mode 0))
