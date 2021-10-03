(require 'pg-straight)
(require 'pg-keybinds)

(use-package helpful
  :straight t
  :config
  (pg/leader
    "h f" #'(helpful-function :which-key "function")
    "h v" #'(helpful-variable :which-key "variable")
    "h m" #'(helpful-macro :which-key "macro")
    "h V" #'(apropos-value :which-key "value")
    "h ." #'(helpful-at-point :which-key "this")
    "h k" #'(helpful-key :which-key "key")))

(provide 'pg-help)
