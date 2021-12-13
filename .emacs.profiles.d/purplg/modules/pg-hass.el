;;; --- -*- lexical-binding: t; -*-

;; Dev
(use-package hass
  :init
  ;; Dev packages aren't resolved automatically
  (straight-use-package 'request)
  (straight-use-package 'websocket)

  :config
  ;; Initial config
  (setq hass-host "10.0.2.3")
  (setq hass-insecure t)
  (setq hass-apikey (auth-source-pass-get 'secret "home/hass/emacs-apikey"))
  (setq hass-watched-entities '("switch.bedroom_light"))
  (hass-setup)
  
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

(provide 'pg-hass)
