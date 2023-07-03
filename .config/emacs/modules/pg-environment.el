;;; --- -*- lexical-binding: t; -*-

(require 'pg-package)

(use-package exec-path-from-shell
  :functions exec-path-from-shell-initialize
  :init
  (setq exec-path-from-shell-variables '("PATH" "MANPATH" "SSH_AUTH_SOCK"))
  (exec-path-from-shell-initialize)
  (with-eval-after-load 'magit
    (add-hook 'magit-status-mode-hook
              (lambda ()
                (exec-path-from-shell-initialize)))))

(use-package envrc
  :init
  (envrc-global-mode))

(use-package keychain-environment
  :if (executable-find "keychain")
  :init
  (keychain-refresh-environment))

(provide 'pg-environment)
