;;; --- -*- lexical-binding: t; -*-

(require 'pg-package)
(require 'pg-keybinds)

(use-package embark-consult)

(use-package embark
  :after embark-consult
  :config
  (evil-define-key* '(normal visual insert) 'global
   (kbd "C-.") #'embark-act)

  (evil-define-key* '(normal insert)
   minibuffer-local-map
   (kbd "C-.") #'embark-act
   (kbd "C-,") #'embark-become))

(provide 'pg-embark)
