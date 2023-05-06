;;; --- -*- lexical-binding: t; -*-
(require 'pg-keybinds)

(use-package ement
  :init
  (defun pg/ement-connect ()
    (interactive)
    (ement-connect
      :user-id (concat "@" (auth-source-pass-get "username" "matrix.org") ":matrix.org")
      :password (auth-source-pass-get 'secret "matrix.org")))

  (evil-define-key 'normal 'global
   (kbd "<leader> o m") #'("Matrix" . ement-list-rooms))

  :config
  ;; Don't open room list automatically
  (remove-hook 'ement-after-initial-sync-hook 'ement-list-rooms)

  (evil-define-key '(normal insert visual) ement-room-list-mode-map
   (kbd "<return>") #'ement-room-list-RET)
  
  (evil-define-key '(normal insert visual) ement-room-mode-map
   (kbd "<return>") #'ement-room-send-message
   (kbd "e")        #'ement-room-send-emote
   (kbd "r")        #'ement-room-send-reply
   (kbd "d")        #'ement-room-delete-message)

  (pg/ement-connect))

  
(provide 'pg-matrix)
