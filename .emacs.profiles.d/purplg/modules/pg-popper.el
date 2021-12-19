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
                                    telega-root-mode
                                    telega-chat-mode
                                    flymake-project-diagnostics-mode))

  (defun popper-popup-at-bottom (buffer &optional _alist)
    "Display popup-buffer BUFFER at the bottom of the screen."
    (display-buffer-in-side-window
     buffer
     `((window-height . ,popper-window-height)
       (side . bottom)
       (slot . 1))))

  (setq popper-display-function #'popper-popup-at-bottom)

  :config
  (popper-mode +1))
  
(provide 'pg-popper)
