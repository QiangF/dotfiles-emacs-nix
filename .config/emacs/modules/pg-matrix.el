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
    (kbd "<leader> o m") #'("Matrix" . pg/ement-connect))

  :config
  ;; Rebind ement-connect to show rooms
  (add-hook 'ement-after-initial-sync-hook
            (lambda (&rest _)
              (evil-define-key 'normal 'global
                (kbd "<leader> o m") #'("Matrix" . ement-list-rooms))))

  (evil-define-key '(normal insert visual) ement-room-list-mode-map
    (kbd "<return>") #'ement-room-list-RET)
  
  (evil-define-key '(normal insert visual) ement-room-mode-map
    (kbd "<return>") #'ement-room-send-message
    (kbd "e")        #'ement-room-send-emote
    (kbd "i")        #'ement-room-edit-message
    (kbd "r")        #'ement-room-write-reply
    (kbd "d")        #'ement-room-delete-message
    (kbd "q")        #'bury-buffer))

  
(provide 'pg-matrix)
