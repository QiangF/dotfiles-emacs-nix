;;; --- -*- lexical-binding: t; -*-
(require 'pg-straight)
(require 'pg-pass)

;; Automatically pull credentials and autojoin channels from ~pass~.
;; Can't figure out why =erc-autojoin-channels-alist= isn't working even when passing a list of strings directly
(use-package erc
  :straight t
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
  (setq erc-prompt-for-password nil
        erc-kill-buffer-on-part t
        erc-kill-server-buffer-on-quit t
        erc-autojoin-channels-alist `(("irc.libera.chat" ,(split-string (auth-source-pass-get "libera-channels" "irc.libera.chat")))))

  (pg/connect-to-irc))

(provide 'pg-irc)
