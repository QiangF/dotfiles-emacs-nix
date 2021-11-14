;;; --- -*- lexical-binding: t; -*-

(use-package pass
 :config
 (setq auth-sources #'(password-store)))

(provide 'pg-pass)
