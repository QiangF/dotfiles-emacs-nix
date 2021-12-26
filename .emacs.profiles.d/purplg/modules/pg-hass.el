;;; --- -*- lexical-binding: t; -*-

;; Dev
(use-package hass
  :straight t
  ;; :straight (:local-repo "~/code/elisp/hass")
  :init
  ;; Dev packages aren't resolved automatically
  (straight-use-package 'request)
  (setq hass-host "10.0.2.3")
  (setq hass-insecure t)
  (setq hass-apikey (auth-source-pass-get 'secret "home/hass/emacs-apikey"))
  :config
  (hass-setup))

(use-package hass-websockets
  ;; :straight (:type git :host github :repo "purplg/hass-websockets")
  :straight (:local-repo "~/code/elisp/hass-websockets")
  :after hass
  :init
  ;; Dev packages aren't resolved automatically
  (straight-use-package 'websocket)

  ;; An automation just to "eat my own dogfood".
  ;; Changes Emacs theme based on the state of my bedroom light.
  (setq hass-tracked-entities '("switch.bedroom_light"))
  (setq pg/hass-original-theme current-theme)
  (add-hook 'hass-entity-state-updated-functions
    (lambda (entity-id)
      (cond ((string= entity-id "switch.bedroom_light")
             (if (hass-switch-p entity-id)
                 (set-theme 'doom-one-light)
                 (set-theme pg/hass-original-theme))))))

  (hass-realtime-mode t))

(provide 'pg-hass)
