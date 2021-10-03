(require 'pg-straight)

;; Copy my user enviroment settings into Emacs. Necessary for some things like using Rust Cargo crates
(when (daemonp)
  (use-package exec-path-from-shell
    :straight t
    :init
    (exec-path-from-shell-initialize)))

(provide 'pg-daemon)
