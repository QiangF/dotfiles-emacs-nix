;;; --- -*- lexical-binding: t; -*-
(require 'pg-keybinds)

(use-package ement
  :straight (:type git :host github :repo "alphapapa/ement.el")
  :after plz
  :init
  ;; Connection wrapper
  (defun pg/ement-connect ()
    (interactive)
    (ement-connect
      :user-id (concat "@" (auth-source-pass-get "username" "matrix.org") ":matrix.org")
      :password (auth-source-pass-get 'secret "matrix.org")))

  :config
  ;; Don't open room list automatically
  (setq ement-after-initial-sync-hook nil)
  (pg/ement-connect)
  
  ;; Connect to Matrix if not connected.
  (advice-add
   'ement-list-rooms
   :before (lambda () (unless ement-sessions (pg/ement-connect))))
  
  ;; Global Keybinds
  (pg/leader
   :states 'normal
   "o m" #'(ement-list-rooms :wk "Matrix"))

  ;; Ement.el Keybinds
  (general-define-key
   :states '(normal insert visual)
   :keymaps 'ement-room-mode-map
   "<return>" #'ement-room-send-message
   "e"        #'ement-room-send-emote
   "r"        #'ement-room-send-reply
   "d"        #'ement-room-delete-message))
 
  
(provide 'pg-matrix)
