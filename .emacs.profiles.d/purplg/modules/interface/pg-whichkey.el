(require 'pg-straight)

(use-package which-key
  :straight t
  :config
  (setq which-key-idle-delay 1)
  (which-key-mode 1))

(provide 'pg-whichkey)
