;;; --- -*- lexical-binding: t; -*-
(require 'pg-system-specific)

;; Font
(defvar font-face "Fira Code Retina-10")
(set-face-attribute 'default nil :font font-face) 
(add-to-list 'default-frame-alist `(font . ,font-face))

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
