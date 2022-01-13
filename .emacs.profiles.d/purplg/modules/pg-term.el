;;; --- -*- lexical-binding: t; -*-
(require 'pg-keybinds)

(use-package eshell
  :defer t
  :straight t
  :init
  (pg/leader
   "o e" #'(eshell :wk "terminal")))

(use-package vterm
  :defer t
  :straight t
  :init
  (pg/leader
   "o t" #'(vterm-other-window :wk "terminal")))

(provide 'pg-term)
