;;; --- -*- lexical-binding: t; -*-

(require 'pg-package)

(use-package popper
  :init
  (setq popper-reference-buffers
        '(messages-buffer-mode "\\*Messages\\*"
           "^\\*helpful.*\\*$"
           "^\\*eldoc.*\\*$"
           "^\\*xref.*\\*$"
           eshell-mode "^\\*eshell.*\\*$"
           flycheck-error-list-mode
           compilation-mode
           hass-dash-mode
	   inferior-python-mode
           emacs-lisp-compilation-mode
           "^\\*Warnings\\*$"
           flymake-diagnostics-buffer-mode
           flymake-project-diagnostics-mode))

  (setq popper-display-control nil)
  (setq popper-display-function #'popper-display-popup-at-bottom)

  (popper-mode +1)

  :config
  (evil-define-key* '(normal insert) popper-mode-map
   (kbd "C-`") #'popper-toggle-latest
   (kbd "M-`") #'popper-cycle
   (kbd "C-M-`") #'popper-toggle-type))

(use-package shackle
  :after popper
  :init
  (setq shackle-select-reused-windows t)
  (setq shackle-rules `((hass-dash-mode :align left :size 0.2)
                        (compilation-mode :regexp t :select nil)
                        ;; (telega-chat-mode :popup t :select t :align left)
                        (,popper-reference-buffers :regexp t :align below :size 0.3)))
  (shackle-mode +1))

(provide 'pg-popper)
