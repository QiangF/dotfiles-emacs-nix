;;; --- -*- lexical-binding: t; -*-
(require 'pg-keybinds)

(use-package helpful
  :config
  (pg/leader
   "h f" #'(helpful-function :wk "function")
   "h v" #'(helpful-variable :wk "variable")
   "h m" #'(helpful-macro :wk "macro")
   "h V" #'(apropos-value :wk "value")
   "h ." #'(helpful-at-point :wk "this")
   "h k" #'(helpful-key :wk "key")))

(provide 'pg-help)