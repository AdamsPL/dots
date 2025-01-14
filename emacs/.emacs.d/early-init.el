;; -*- lexical-binding:t -*-

(setq gc-cons-threshold (* 32 1024 1024))

(setq inhibit-startup-message t)
(setq initial-scratch-message nil)
(setq initial-major-mode 'fundamental-mode)
(setq warning-minimum-level :error)

(make-directory "/tmp/emacs" t)
(setq custom-file "~/.emacs.d/custom.el")
(setq create-lockfiles nil)
(setq backup-directory-alist '(("." . "/tmp/emacs/backups")))
(setq backup-by-copying t)
(setq delete-old-versions t)
(setq kept-new-versions 8)
(setq kept-old-versions 2)
(setq version-control t)
(setq auto-save-file-name-transforms '((".*" "/tmp/emacs/backups" t)))

(setq load-prefer-newer t)
(setq native-comp-jit-compilation t)

(menu-bar-mode 0)
(when initial-window-system
  (tool-bar-mode 0)
  (scroll-bar-mode 0))
  (set-face-attribute )
  (set-face-attribute 'default nil :font "Inconsolata Nerd Font Mono" :height 120)

