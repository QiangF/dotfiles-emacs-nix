;;; --- -*- lexical-binding: t; -*-
(require 'pg-keybinds)

(use-package telega
  :straight t
  :init
  (setq telega-completing-read-function #'completing-read)
  (setq telega-emoji-use-images t)
  (setq telega-chat-show-avatars t)
  (setq telega-root-show-avatars t)
  (setq telega-user-show-avatars t)
  (setq telega-emoji-font-family "Noto Color Emoji")
  (setq telega-use-images t)

  ;; Issues with colors while in daemon mode is causing it to fail on load. So load telega after a
  ;; frame is created
  (add-hook 'server-after-make-frame-hook (lambda () (telega 0)))

  :config
  (telega-mode-line-mode 1)
  (pg/leader "c" telega-prefix-map)
  (pg/leader "C" #'(telega :whick-key "telegram"))

  :general
  (:keymaps 'telega-chat-mode-map
   "C-g" #'telega-chatbuf-cancel-aux))

(use-package alert
  :straight t)

(use-package telega-alert
  :after telega alert
  :config
  (telega-alert-mode 1)
  (add-hook 'telega-load-hook #'global-telega-squash-message-mode)
  (alert-add-rule
    :mode 'telega-chat-mode
    :style 'notifications))

(use-package telega-dashboard
  :after telega dashboard
  :config
  (defun dashboard-refresh-buffer-silent ()
    "Refresh buffer in background."
    (interactive)
    (let ((dashboard-force-refresh t)) (dashboard-insert-startupify-lists)))

  (add-to-list 'dashboard-items '(telega-chats . 5) t)
  (add-hook 'telega-chat-update-hook (lambda (&rest _) (dashboard-refresh-buffer-silent)))
  (general-define-key
   :states 'normal
   :keymaps 'dashboard-mode-map
   "t" #'dashboard-jump-to-telega-chats))
  
(provide 'pg-telegram)
