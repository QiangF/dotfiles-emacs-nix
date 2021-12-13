;;; --- -*- lexical-binding: t; -*-

(use-package popper
 :general
 ("C-`" #'popper-toggle-latest)
 ("M-`" #'popper-cycle)
 ("C-M-`" #'popper-toggle-type)
 :init
 (setq popper-reference-buffers '("\\*Messages\\*"
                                  compilation-mode
                                  rustic-compilation-mode
                                  "^\\*helpful.*\\*$"))
 :config
 (popper-mode +1))
  
(provide 'pg-popper)
