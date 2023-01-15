;;; --- -*- lexical-binding: t; -*-

(use-package exec-path-from-shell
  :functions exec-path-from-shell-initialize
  :init
  (exec-path-from-shell-initialize))

(use-package envrc
  :init
  (envrc-global-mode))

(provide 'pg-environment)
