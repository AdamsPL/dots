;; -*- lexical-binding:t -*-

(setq gc-cons-threshold (* 128 1024 1024))
(setq package-enable-at-startup nil)

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
