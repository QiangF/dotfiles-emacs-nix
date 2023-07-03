;;; --- -*- lexical-binding: t; -*-

(require 'pg-package)
(require 'pg-keybinds)

(defun pg/ement/after-sync-hook (&rest _)
  ;; Rebind ement-connect to show room list
  (evil-define-key 'normal 'global
    (kbd "<leader> o m") #'("Matrix" . ement-room-list-side-window)))

(defun pg/ement/disconnect-hook (&rest _)
  ;; Rebind ement-connect to show room list
  (evil-define-key 'normal 'global
    (kbd "<leader> o m") #'("Matrix" . ement-connect)))

(use-package ement
  :custom (ement-save-sessions t)
          (ement-room-prism 'both)
          (ement-room-send-message-filter #'ement-room-send-org-filter)
  :hook (ement-disconnect-hook . #'pg/ement/disconnect-hook)
  :init
  (pg/ement/disconnect-hook)

  :config
  ;; Don't show room list after connect
  (remove-hook 'ement-after-initial-sync-hook 'ement-room-list--after-initial-sync)

  ;; Rebind ement-connect to show rooms
  (add-hook 'ement-after-initial-sync-hook 'pg/ement/after-sync-hook)

  (evil-define-key '(normal insert visual) ement-room-list-mode-map
    (kbd "<return>") #'ement-room-list-RET)
  
  (evil-define-key '(normal insert visual) ement-room-mode-map
    (kbd "t") #'ement-room-send-message
    (kbd "e") #'ement-room-send-emote
    (kbd "i") #'ement-room-edit-message
    (kbd "r") #'ement-room-write-reply
    (kbd "d") #'ement-room-delete-message
    (kbd "?") #'ement-room-transient
    (kbd "q") #'bury-buffer))

(provide 'pg-matrix)
