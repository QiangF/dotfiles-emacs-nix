;;; --- -*- lexical-binding: t; -*-

(use-package popper
  :general
  ("C-`" #'popper-toggle-latest)
  ("M-`" #'popper-cycle)
  ("C-M-`" #'popper-toggle-type)
  :init
  (setq popper-reference-buffers '("\\*Messages\\*"
                                    "^\\*helpful.*\\*$"
                                    "^\\*eldoc.*\\*$"
                                    flycheck-error-list-mode
                                    compilation-mode
                                    rustic-compilation-mode
                                    flymake-diagnostics-buffer-mode
                                    flymake-project-diagnostics-mode))
  :config
  (popper-mode +1))
  
(provide 'pg-popper)
