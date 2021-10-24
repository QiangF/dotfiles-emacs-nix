;;; --- -*- lexical-binding: t; -*-
(require 'pg-straight)

;; Dev
(use-package hass
  :straight '(:local-repo "~/code/elisp/hass")

  :init
  ;; Dev packages aren't resolved automatically
  (use-package request :straight t)
  (use-package websocket :straight t)

  :config
  ;; Initial config
  (hass-setup
    :host "10.0.2.3"
    :insecure t
    :apikey (auth-source-pass-get 'secret "home/hass/emacs-apikey")
    :watch '("switch.bedroom_light"))
  
  (setq pg/hass-original-theme current-theme)

  ;; An automation just to "eat my own dogfood".
  ;; Changes Emacs theme based on the state of my bedroom light.
  (add-hook 'hass-entity-state-updated-functions
    (lambda (entity-id)
      (cond ((string= entity-id "switch.bedroom_light")
             (if (hass-switch-p entity-id)
                 (set-theme 'doom-one-light)
                 (set-theme pg/hass-original-theme))))))
  (hass-realtime-mode t))

;; Prod
(use-package hass
  :disabled
  :straight t
  :init (setq hass-url "http://homeassistant:8123")
        (setq hass-apikey (auth-source-pass-get 'secret "home/hass/emacs-apikey"))
        (hass-setup))

(provide 'pg-hass)
