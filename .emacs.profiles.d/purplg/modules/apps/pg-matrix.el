;;; --- -*- lexical-binding: t; -*-
(require 'pg-straight)
(require 'pg-keybinds)

(use-package plz
  :straight (plz :type git
                 :host github
                 :repo "alphapapa/plz.el"))

(use-package ement
  :after plz
  :straight (ement :type git
                   :host github
                   :repo "alphapapa/ement.el")
  :config

  ;; Don't open room list automatically
  (setq ement-after-initial-sync-hook nil)
  
  ;; Connection wrapper
  (defun pg/ement-connect ()
    (ement-connect
      :user-id (concat "@" (auth-source-pass-get "username" "matrix.org") ":matrix.org")
      :password (auth-source-pass-get 'secret "matrix.org")))
  (pg/ement-connect)
  
  ;; Connect to Matrix if not connected.
  (advice-add
   'ement-list-rooms
   :before (lambda () (unless ement-sessions (pg/ement-connect))))
  
  ;; Keybinds
  (pg/leader
   :states 'normal
   "o m" #'(ement-list-rooms :wk "Matrix")))
  
(provide 'pg-matrix)
