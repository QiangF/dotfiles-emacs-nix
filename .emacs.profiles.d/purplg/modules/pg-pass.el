;;; --- -*- lexical-binding: t; -*-

(use-package pass
  :straight t
  :config
  (add-to-list 'auth-sources 'password-store))

(provide 'pg-pass)
