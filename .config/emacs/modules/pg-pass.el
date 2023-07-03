;;; --- -*- lexical-binding: t; -*-

(require 'pg-package)

(use-package pass
  :init
  (add-to-list 'auth-sources 'password-store))

(provide 'pg-pass)
