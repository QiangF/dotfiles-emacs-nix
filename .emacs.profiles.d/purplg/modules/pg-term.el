;;; --- -*- lexical-binding: t; -*-
(require 'pg-keybinds)

(use-package eshell
  :config
  (pg/leader
   "o t" #'eshell))

(provide 'pg-term)
