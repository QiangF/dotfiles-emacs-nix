(require 'pg-straight)

(use-package undo-fu
  :straight t)

(use-package undo-fu-session
  :straight t
  :after undo-fu
  :config
  (setq undo-fu-session-incompatible-files '("/COMMIT_EDITMSG\\'" "/git-rebase-todo\\'"))
  (global-undo-fu-session-mode))


(provide 'pg-undo)
