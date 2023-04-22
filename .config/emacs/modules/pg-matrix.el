;;; --- -*- lexical-binding: t; -*-
(require 'pg-keybinds)

(use-package ement
  :straight t
  :init
  ;; Connection wrapper
  (defun pg/ement-connect ()
    (interactive)
    (ement-connect
      :user-id (concat "@" (auth-source-pass-get "username" "matrix.org") ":matrix.org")
      :password (auth-source-pass-get 'secret "matrix.org")))
  
  (pg/leader
   :states 'normal
   "o m" #'(ement-list-rooms :wk "Matrix"))

  :config
  ;; Don't open room list automatically
  (remove-hook 'ement-after-initial-sync-hook 'ement-list-rooms)

  (general-define-key
   :states '(normal insert visual)
   :keymaps 'ement-room-mode-map
   "<return>" #'ement-room-send-message
   "e"        #'ement-room-send-emote
   "r"        #'ement-room-send-reply
   "d"        #'ement-room-delete-message)

  (pg/ement-connect))

  
(provide 'pg-matrix)
