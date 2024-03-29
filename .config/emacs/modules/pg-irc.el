;;; --- -*- lexical-binding: t; -*-

(require 'pg-package)
(require 'pg-pass)

;; Automatically pull credentials and autojoin channels from ~pass~.
;; Can't figure out why =erc-autojoin-channels-alist= isn't working even when passing a list of strings directly
(use-package erc
  :disabled
  :after pass
  :init
  (defun pg/connect-to-irc ()
    (interactive)
    (erc-tls
     :server "irc.libera.chat"
     :port "6697"
     :nick (auth-source-pass-get "nick" "irc.libera.chat")
     :password (auth-source-pass-get 'secret "irc.libera.chat")))

  :config
  (setq erc-prompt-for-password nil)
  (setq erc-kill-buffer-on-part t)
  (setq erc-kill-server-buffer-on-quit t)
  (setq erc-autojoin-channels-alist `(("irc.libera.chat" ,(split-string (auth-source-pass-get "libera-channels" "irc.libera.chat")))))

  (pg/connect-to-irc))

(provide 'pg-irc)
