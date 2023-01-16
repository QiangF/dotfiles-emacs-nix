;;; --- -*- lexical-binding: t; -*-
(require 'pg-keybinds)

(use-package telega
  :after dash
  :commands (telega)
  :init
  (setq telega-completing-read-function #'completing-read)
  (setq telega-emoji-use-images t)
  (setq telega-chat-show-avatars t)
  (setq telega-root-show-avatars t)
  (setq telega-user-show-avatars t)
  (setq telega-emoji-font-family "Noto Color Emoji")
  (setq telega-use-images t)

  (defun pg/telega-online-status-function ()
    (let ((telega-buffers (telega-chat-buffers)))
      (push (telega-root--buffer) telega-buffers)
      (-any? (lambda (buffer) (get-buffer-window buffer))
             telega-buffers)))
  (setq telega-online-status-function #'pg/telega-online-status-function)

  ;; Issues with colors while in daemon mode is causing it to fail on load. So load telega after a
  ;; frame is created
  (add-hook 'server-after-make-frame-hook (lambda () (telega 0)))
  (pg/leader "c" telega-prefix-map)

  (setq telega-chat-button-brackets
        '(((type private)    "p|" "")
          ((type basicgroup) "g|" "")
          ((type supergroup) "s|" "")
          ((type channel)    "c|" "")
          (all               "--" "")))

  :config
  (evil-set-initial-state 'telega-chat-mode 'insert)
  (with-eval-after-load 'persp-mode
    (add-hook 'telega-chat-mode-hook (lambda () (persp-switch "telegram")))
    (add-hook 'telega-root-mode-hook
              (lambda ()
                (unless (persp-with-name-exists-p "telegram")
                  (persp-add-new "telegram"))
                (persp-add-buffer telega-root-buffer-name (persp-get-by-name "telegram")))))

  ;; Make chat window dedicated
  (advice-add #'telega-chatbuf--switch-in
              :after
              (lambda (&rest _)
                (set-window-dedicated-p (get-buffer-window (current-buffer)) t)))

  (set-face-background 'telega-msg-heading "#1b1326")
  (telega-mode-line-mode 1)

  :general
  (:keymaps 'telega-chat-mode-map
            "C-g" #'telega-chatbuf-cancel-aux))

(use-package alert)

(use-package telega-alert
  :straight nil
  :after telega alert
  :config
  (telega-alert-mode 1)
  (add-hook 'telega-load-hook #'global-telega-squash-message-mode)
  (alert-add-rule
    :mode 'telega-chat-mode
    :style 'notifications))

(use-package telega-dashboard
  :disabled
  :straight nil
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
