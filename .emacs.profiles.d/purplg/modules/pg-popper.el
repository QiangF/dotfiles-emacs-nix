;;; --- -*- lexical-binding: t; -*-

(use-package popper
 :general
 ("C-`" #'popper-toggle-latest)
 ("M-`" #'popper-cycle)
 ("C-M-`" #'popper-toggle-type)
 :init
 (setq popper-reference-buffers '("\\*Messages\\*"
                                  "^\\*helpful.*\\*$"
                                  compilation-mode
                                  rustic-compilation-mode
                                  flymake-diagnostics-buffer-mode))
 :config
 (popper-mode +1))
  
(provide 'pg-popper)
