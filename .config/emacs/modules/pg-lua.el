;;; --- -*- lexical-binding: t; -*-

(use-package lua-mode
  :init
  (autoload 'lua-mode "lua-mode" "Lua editing mode." t)
  (add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
  (add-to-list 'interpreter-mode-alist '("lua"  . lua-mode)))

(provide 'pg-lua)
