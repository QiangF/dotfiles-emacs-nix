;;; --- -*- lexical-binding: t; -*-

(use-package popper
  :straight t
  :init
  (setq popper-reference-buffers
        '(messages-buffer-mode "\\*Messages\\*"
           "^\\*helpful.*\\*$"
           "^\\*eldoc.*\\*$"
           "^\\*xref.*\\*$"
           eshell-mode "^\\*eshell.*\\*$"
           vterm-mode "^\\*vterm.*\\*$"
           flycheck-error-list-mode
           compilation-mode
           hass-dash-mode
           emacs-lisp-compilation-mode
           "^\\*rustfmt\\*$"
           "^\\*Warnings\\*$"
           rustic-compilation-mode
           rustic-format-mode
           rustic-cargo-fmt-mode
           flymake-diagnostics-buffer-mode
           flymake-project-diagnostics-mode))

  (setq popper-display-control nil)
  (setq popper-display-function #'popper-display-popup-at-bottom)

  (popper-mode +1)
  :general
  ("C-`" #'popper-toggle-latest)
  ("M-`" #'popper-cycle)
  ("C-M-`" #'popper-toggle-type))

(use-package shackle
  :straight t
  :init
  (setq shackle-select-reused-windows t)
  (setq shackle-rules `((hass-dash-mode :align left :size 0.1)
                        (compilation-mode :regexp t :select nil)
                        ;; (telega-chat-mode :popup t :select t :align left)
                        (,popper-reference-buffers :regexp t :align below :size 0.3)))
  (shackle-mode +1))
  
(provide 'pg-popper)