;;; --- -*- lexical-binding: t; -*-

(use-package exec-path-from-shell
  :functions exec-path-from-shell-initialize
  :init
  (setq exec-path-from-shell-variables '("PATH" "MANPATH" "SSH_AUTH_SOCK"))
  (exec-path-from-shell-initialize))

(use-package envrc
  :init
  (envrc-global-mode))

(use-package keychain-environment
  :if (executable-find "keychain")
  :init
  (keychain-refresh-environment))

(provide 'pg-environment)
