;;; --- -*- lexical-binding: t; -*-
(require 'pg-keybinds)

(defun pg/ement/after-sync-hook (&rest _)
  ;; Rebind ement-connect to show room list
  (evil-define-key 'normal 'global
    (kbd "<leader> o m") #'("Matrix" . ement-room-list-side-window)))

(use-package ement
  :init
  (evil-define-key 'normal 'global
    (kbd "<leader> o m") #'("Matrix" . ement-connect))

  :config
  (setopt ement-save-sessions t)

  ;; Don't show room list after connect
  (remove-hook 'ement-after-initial-sync-hook 'ement-room-list--after-initial-sync)

  ;; Rebind ement-connect to show rooms
  (add-hook 'ement-after-initial-sync-hook 'pg/ement/after-sync-hook)

  (evil-define-key '(normal insert visual) ement-room-list-mode-map
    (kbd "<return>") #'ement-room-list-RET)
  
  (evil-define-key '(normal insert visual) ement-room-mode-map
    (kbd "<return>") #'ement-room-send-message
    (kbd "e")        #'ement-room-send-emote
    (kbd "i")        #'ement-room-edit-message
    (kbd "r")        #'ement-room-write-reply
    (kbd "d")        #'ement-room-delete-message
    (kbd "?")        #'ement-room-transient
    (kbd "q")        #'bury-buffer))

  
(provide 'pg-matrix)
