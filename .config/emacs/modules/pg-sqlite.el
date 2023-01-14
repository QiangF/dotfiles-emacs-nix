;;; --- -*- lexical-binding: t; -*-
(require 'pg-keybinds)

(use-package sqlite-mode
  :if (version< "29" emacs-version)
  :straight nil
  :after evil
  :config
  (evil-define-key* 'normal sqlite-mode-map
    (kbd "RET") #'sqlite-mode-list-data
    [tab] #'sqlite-mode-list-columns))

(provide 'pg-sqlite)
