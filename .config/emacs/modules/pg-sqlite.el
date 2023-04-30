;;; --- -*- lexical-binding: t; -*-
(require 'pg-keybinds)

(use-package sqlite-mode
  :if (version< "29" emacs-version)
  :elpaca nil
  :after evil
  :config
  (evil-define-key* 'normal sqlite-mode-map
    (kbd "<return>") #'sqlite-mode-list-data
    (kbd "<tab>") #'sqlite-mode-list-columns))

(provide 'pg-sqlite)
