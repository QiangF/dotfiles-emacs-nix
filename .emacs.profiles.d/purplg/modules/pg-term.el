;;; --- -*- lexical-binding: t; -*-
(require 'pg-keybinds)

(use-package eshell
  :straight t
  :config
  (pg/leader
   "o t" #'eshell))

(provide 'pg-term)
