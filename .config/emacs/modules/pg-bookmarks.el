;;; --- -*- lexical-binding: t; -*-

(require 'pg-package)
(require 'pg-keybinds)

(use-package bookmark
  :elpaca nil
  :after evil bookmark
  :config
  (evil-define-key 'normal 'global
    (kbd "<leader> m") bookmark-map))

(provide 'pg-bookmarks)
