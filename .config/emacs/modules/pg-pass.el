;;; --- -*- lexical-binding: t; -*-

(use-package pass
  :init
  (add-to-list 'auth-sources 'password-store))

(provide 'pg-pass)
