;;; --- -*- lexical-binding: t; -*-
(require 'pg-keybinds)

(use-package eshell
  :elpaca nil
  :defer t
  :init
  (with-eval-after-load 'evil
    (evil-define-key* 'normal 'global
      (kbd "<leader> o e") #'(eshell :wk "terminal"))))

(use-package vterm
  :defer t
  :init
  ;; Close the window when vterm exits
  (add-hook 'vterm-exit-functions
            (lambda (buffer _event)
              (delete-window (get-buffer-window buffer))))
  (evil-define-key 'normal 'global
   (kbd "<leader> o t") #'(vterm-other-window :wk "terminal")))

(provide 'pg-term)
