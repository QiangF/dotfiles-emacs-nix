;;; --- -*- lexical-binding: t; -*-
(require 'pg-keybinds)

(use-package bookmark
  :elpaca nil
  :after evil
  :init
  (evil-define-key 'normal 'global
    (kbd "<leader> m") bookmark-map))

(provide 'pg-bookmarks)
