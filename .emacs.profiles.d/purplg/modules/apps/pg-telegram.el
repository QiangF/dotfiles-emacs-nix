;;; --- -*- lexical-binding: t; -*-
(require 'pg-straight)
(require 'pg-keybinds)

(use-package alert
  :straight t)

(use-package telega
  :straight t
  :if (daemonp)
  :init
  (telega)
  (telega-mode-line-mode 1)

  :custom
  (telega-emoji-use-images t)
  (telega-chat-show-avatars t)
  (telega-root-show-avatars t)
  (telega-user-show-avatars t)
  (telega-emoji-font-family "Noto Color Emoji")

  :config
  ;; Cannot set this with `:custom' in daemon mode for some reason
  (setq telega-use-images t)

  (pg/leader
   "o c" #'(telega :whick-key "telegram"))

  :general
  (:keymaps 'telega-chat-mode-map
   "C-g" #'telega-chatbuf-cancel-aux))

(use-package telega-alert
  :after telega alert
  :config
  (telega-alert-mode 1)
  (hook! 'telega-load-hook #'global-telega-squash-message-mode))

(use-package telega-dashboard
  :after telega dashboard
  :config
  (add-to-list 'dashboard-items '(telega-chats . 5) t)
  (hook! 'telega-chat-update-hook (lambda (&rest _) (dashboard-refresh-buffer-silent)))
  (general-define-key
   :states 'normal
   :keymaps 'dashboard-mode-map
   "t" #'dashboard-jump-to-telega-chats))
  
(provide 'pg-telegram)
