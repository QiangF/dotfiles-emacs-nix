;;; pg-apps.el --- -*- lexical-binding: t; -*-
(require 'pg-straight)
(require 'pg-keybinds)

(use-package org
  :straight t

  :config
  (setq org-return-follows-link t           ;; Press Enter to follow link under point
        org-adapt-indentation nil           ;; Stop putting indents everywhere
        org-edit-src-content-indentation 0  ;; Fixes indenting entire src block on enter
        org-src-preserve-indentation t      ;; Stop annoying bug with indenting elisp in a code block
        org-confirm-babel-evaluate nil      ;; Don't ask for confirmation when executing a codeblock
        org-directory "~/.org"
        org-agenda-files '("~/.org/PC.org")
        org-capture-project-file "project.org"
        org-capture-templates
        '(("w" "Work"
            entry (file+headline "~/.org/Work.org" "Tasks")
            "* TODO %?\n %i\n")

          ("p" "Current project"
            entry (file+headline (lambda () (expand-file-name org-capture-project-file (projectile-project-root))) "Tasks")
            "* TODO %?\n%i\n%a" :prepend t)

          ("s" "Session"
            entry (file+headline "~/.org/PC.org" "Session")
            "* TODO %?\n%i" :prepend t)

          ("c" "PC"
            entry (file+headline "~/.org/PC.org" "Tasks")
            "* TODO %?\n%i" :prepend t)

          ("h" "Home"
            entry (file+headline "~/.org/Home.org" "Tasks")
            "* TODO %?\n%i" :prepend t)))

  (hook! 'org-mode-hook #'(flyspell-mode org-indent-mode))

  (pg/leader
    "X" #'org-capture)

  (pg/leader
    :keymaps 'org-mode-map
    "t l" #'(org-toggle-link-display :which-key "link display"))
    
  :general
  (:states 'normal
   :keymaps 'org-src-mode-map
   "C-c C-c" #'org-edit-src-exit))
   
(use-package htmlize
  :straight t
  :after org)

(use-package pass
  :straight t
  :config
  (setq auth-sources #'(password-store)))

;; Automatically pull credentials and autojoin channels from ~pass~.
;; Can't figure out why =erc-autojoin-channels-alist= isn't working even when passing a list of strings directly

(use-package erc
  :straight t
  :disabled
  :after pass
  :init
  (defun pg/connect-to-irc ()
    (interactive)
    (erc-tls :server   "irc.libera.chat"
             :port     "6697"
             :nick     (auth-source-pass-get "nick" "irc.libera.chat")
             :password (auth-source-pass-get 'secret "irc.libera.chat")))

  :config
  (setq erc-prompt-for-password nil
        erc-kill-buffer-on-part t
        erc-kill-server-buffer-on-quit t
        erc-autojoin-channels-alist `(("irc.libera.chat" ,(split-string (auth-source-pass-get "libera-channels" "irc.libera.chat")))))

  (pg/connect-to-irc))

(use-package telega
  :straight t
  :init
  (when (daemonp)
    (telega))

  :config
  (setq telega-use-images t
        telega-emoji-use-images t
        telega-chat-show-avatars t
        telega-root-show-avatars t
        telega-user-show-avatars t
        telega-emoji-font-family "Noto Color Emoji")

  (pg/leader
    "o c" #'(telega :whick-key "telegram"))

  (when (daemonp)
    (telega-mode-line-mode 1))

  (use-package telega-alert
    :after alert
    :config
    (telega-alert-mode 1)
    (hook! 'telega-load-hook #'global-telega-squash-message-mode))

  (after! 'dashboard
    (require 'telega-dashboard)
    (add-to-list 'dashboard-items '(telega-chats . 5) t)
    (hook! 'telega-chat-update-hook (lambda (&rest _) (dashboard-refresh-buffer-silent)))
    (general-define-key
      :states 'normal
      :keymaps 'dashboard-mode-map
      "t" #'dashboard-jump-to-telega-chats))

  :general
  (:keymaps 'telega-chat-mode-map
    "C-g" #'telega-chatbuf-cancel-aux))

(use-package alert
  :straight t)

(use-package eshell
  :straight t
  :config
  (pg/leader
   "o t" #'eshell))

(provide 'pg-apps)
