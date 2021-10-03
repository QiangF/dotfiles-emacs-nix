;;; pg-pass.el --- -*- lexical-binding: t; -*-
(require 'pg-straight)

(use-package pass
 :straight t
 :config
 (setq auth-sources #'(password-store)))
(provide 'pg-pass)
