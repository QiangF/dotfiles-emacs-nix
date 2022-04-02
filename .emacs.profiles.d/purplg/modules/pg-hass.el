;;; --- -*- lexical-binding: t; -*-
(require 'pg-theme)

(use-package websocket
  :straight t)

;; Dev
(use-package hass
  :straight t
  ;; :straight (:local-repo "~/code/elisp/hass")
  :init
  (setq hass-host "10.0.2.3")
  (setq hass-insecure t)
  (setq hass-apikey (auth-source-pass-get 'secret "home/hass/emacs-apikey"))
  (pg/leader
   :states 'normal
   "a" #'(:ignore t :wk "Automation")
   "a c" #'(hass-call-service :wk "Call service"))

  (add-to-list 'popper-reference-buffers "^\\*hass-dash.*\\*$")
  (add-to-list 'popper-reference-buffers 'hass-dash-mode)

  :config
  (hass-setup))

(use-package hass
  :after websocket
  :config
  (setq hass-dash-layout '(("Light" . (("switch.bedroom_light" :name "Bedroom Light")))
                           ("PC" . (("switch.desktop" :name "Desktop")
                                    ("switch.framework_mqtt" :name "Framework")
                                    ("switch.laptopbig_mqtt" :name "LaptopBig")))
                           ("Test" . (("input_boolean.hass_mode_test")
                                      ("input_boolean.hass_mode_test" :name "Turn off Hass mode test"
                                                                      :service "input_boolean.turn_off"
                                                                      :state "vacuum.valetudo_vacuum")
                                      ("scene.test_scene" :state nil)))
                           ("Vacuum" . (("vacuum.valetudo_vacuum" :name "State")
                                        ("vacuum.valetudo_vacuum" :name "Clean"
                                                                  :state nil)
                                        ("vacuum.valetudo_vacuum" :name "Return to base"
                                                                  :service "vacuum.return_to_base"
                                                                  :state nil)
                                        ("vacuum.valetudo_vacuum" :name "Locate"
                                                                  :service "vacuum.locate"
                                                                  :state nil)))))

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

  (hass-websocket-mode t)

  (pg/leader
   :states 'normal
   "a d" #'(hass-dash-open :wk "Dashboard")))

(provide 'pg-hass)
