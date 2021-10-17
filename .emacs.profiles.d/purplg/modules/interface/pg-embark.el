;;; --- -*- lexical-binding: t; -*-
(require 'pg-straight)
(require 'pg-keybinds)

(use-package embark
  :straight t
  :config
  (general-define-key
   :states '(normal visual insert)
   "C-." #'embark-act))

(provide 'pg-embark)
