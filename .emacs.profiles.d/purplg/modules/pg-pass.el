;;; --- -*- lexical-binding: t; -*-

(use-package pass
  :straight t
  :config
  (setq auth-sources #'(password-store)))

(provide 'pg-pass)
