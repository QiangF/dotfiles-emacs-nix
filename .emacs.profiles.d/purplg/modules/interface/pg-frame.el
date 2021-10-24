;;; --- -*- lexical-binding: t; -*-

(require 'pg-font)

;; Frame title
(setq frame-title-format "PurplEmacs")

;; Don't show startup page
(setq inhibit-startup-message t)

;; Hide extraneous GUI
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(set-fringe-mode 10)

(provide 'pg-frame)
