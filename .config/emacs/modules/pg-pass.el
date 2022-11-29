;;; --- -*- lexical-binding: t; -*-

(use-package pass
  :straight t
  :init
  (add-to-list 'auth-sources 'password-store))

(provide 'pg-pass)
