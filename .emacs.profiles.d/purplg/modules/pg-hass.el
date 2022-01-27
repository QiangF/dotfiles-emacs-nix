;;; --- -*- lexical-binding: t; -*-
(require 'pg-theme)

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
  (setq hass-dash-layout '(("Test" . (("input_boolean.hass_mode_test")
                                      ("switch.bedroom_light" :name "Bedroom Light")
                                      ("input_boolean.hass_mode_test" :name "Turn off Hass mode test"
                                                                      :service "input_boolean.turn_off"
                                                                      :state "vacuum.valetudo_vacuum")
                                      ("scene.test_scene")))
                           ("Vacuum" . (("vacuum.valetudo_vacuum" :name "State")
                                        ("vacuum.valetudo_vacuum" :name "Clean" :icon nil :state nil)
                                        ("vacuum.valetudo_vacuum" :name "Return to base"
                                                                  :state nil
                                                                  :icon nil
                                                                  :service "vacuum.return_to_base")
                                        ("vacuum.valetudo_vacuum" :name "Locate"
                                                                  :icon nil
                                                                  :service "vacuum.locate"
                                                                  :state nil)))))
  (pg/leader
   :states 'normal
   "a" #'(:ignore t :wk "Automation")
   "a d" #'(hass-dash-open :wk "Dashboard")
   "a c" #'(hass-call-service :wk "Call service"))
  :config
  (hass-setup))

(use-package hass
  :after popper
  :init
  (add-to-list 'popper-reference-buffers "^\\*hass-dash.*\\*$")
  (add-to-list 'popper-reference-buffers 'hass-dash-mode))
(use-package hass-websockets
  :straight (:type git :host github :repo "purplg/hass-websockets")
  ;; :straight (:local-repo "~/code/elisp/hass-websockets")
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
