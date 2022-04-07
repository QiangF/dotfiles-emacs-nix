;;; --- -*- lexical-binding: t; -*-
(require 'pg-keybinds)

(use-package helpful
  :straight t
  :demand t
  :config
  (pg/leader
   "h f" #'(helpful-callable :wk "function")
   "h v" #'(helpful-variable :wk "variable")
   "h m" #'(helpful-macro :wk "macro")
   "h V" #'(apropos-value :wk "value")
   "h ." #'(helpful-at-point :wk "this")
   "h k" #'(helpful-key :wk "key")))

(provide 'pg-help)
