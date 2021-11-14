;;; --- -*- lexical-binding: t; -*-
(require 'pg-apps)

;; Copy my user enviroment settings into Emacs. Necessary for some things like using Rust Cargo crates
(use-package exec-path-from-shell
  :functions exec-path-from-shell-initialize
  :init
  (exec-path-from-shell-initialize))

(require 'pg-telegram)

(provide 'pg-daemon)
