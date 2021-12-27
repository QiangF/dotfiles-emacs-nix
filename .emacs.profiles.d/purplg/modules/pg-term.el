;;; --- -*- lexical-binding: t; -*-
(require 'pg-keybinds)

(use-package eshell
  :defer t
  :straight t
  :init
  (pg/leader
   "o t" #'eshell))

(provide 'pg-term)
