;;; --- -*- lexical-binding: t; -*-

(use-package popper
  :straight t
  :general
  ("C-`" #'popper-toggle-latest)
  ("M-`" #'popper-cycle)
  ("C-M-`" #'popper-toggle-type)
  :init
  (setq popper-reference-buffers '("\\*Messages\\*"
                                    "^\\*helpful.*\\*$"
                                    "^\\*eldoc.*\\*$"
                                    "^\\*xref.*\\*$"
                                    "^\\*eshell.*\\*$" eshell-mode
                                    "^\\*vterm.*\\*$" vterm-mode
                                    "^\\*hass-dash.*\\*$" hass-dash-mode
                                    flycheck-error-list-mode
                                    compilation-mode
                                    rustic-compilation-mode
                                    flymake-diagnostics-buffer-mode
                                    telega-root-mode
                                    telega-chat-mode
                                    flymake-project-diagnostics-mode))

  (setq popper-display-control nil)
  (setq popper-display-function #'popper-display-popup-at-bottom)

  (popper-mode +1))

(use-package shackle
  :straight t
  :after popper
  :init
  (setq shackle-rules '((hass-dash-mode :align left :size 0.3)))
  :config
  (shackle-mode +1))
  
(provide 'pg-popper)
