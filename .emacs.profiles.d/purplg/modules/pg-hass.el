;;; --- -*- lexical-binding: t; -*-
(require 'pg-theme)

(use-package websocket
  :straight t)

(use-package hass
  ;; :straight t
  :straight (:local-repo "~/code/elisp/hass")
  :after pass
  :init
  (setq hass-host "homeassistant.lan")
  (setq hass-insecure t)
  (setq hass-apikey (auth-source-pass-get 'secret "home/hass/emacs-apikey"))
  (pg/leader
   :states 'normal
   "a" #'(:ignore t :wk "automation")
   "a c" #'(hass-call-service :wk "Call service"))

  (add-to-list 'popper-reference-buffers "^\\*hass-dash.*\\*$")
  (add-to-list 'popper-reference-buffers 'hass-dash-mode)

  :config
  (hass-setup))

(use-package hass
  :after websocket
  :init
  (cl-defun pg/hass-dash-widget-formatter (label state icon &optional icon-formatter label-formatter state-formatter)
    (concat (when icon (funcall icon-formatter icon))
            (when state (funcall state-formatter state))
            (funcall label-formatter label)))

  (defun pg/hass-dash-state-formatter (label)
    (concat " " (propertize label
                  'face 'all-the-icons-purple)))

  (setq hass-dash-default-state-formatter #'pg/hass-dash-state-formatter)

  (defun pg/percent-suffix (str)
    (concat " " (propertize (concat str "%")
                  'face 'all-the-icons-purple)))

  (defun pg/laptop-toggle-widget-formatter (_label state icon
                                            label-formatter _state-formatter icon-formatter)
    (if (string= "on" state)
      (concat (when icon (funcall icon-formatter icon))
              (funcall label-formatter "Turn off"))
      "Powered off"))

  (defun pg/hide-unavailable (widget)
    (string= "unavailable" (hass-state-of (car widget))))

  (defun pg/hass-dash-light-label-formatter (label)
    (propertize label 'face 'font-lock-function-name-face))

  (defun pg/hass-dash-light-state-formatter (label)
    (concat ": "
      (propertize label 'face 'font-lock-keyword-face)))

  (defun pg/hass-dash-light-icon-formatter (icon)
    (concat icon "|"))

  (setq pg/hass-dash-group-light
    '("Light" .
      (("switch.bedroom_light"
        :label "Bedroom"
        :widget-formatter (lambda (label state icon label-formatter state-formatter icon-formatter)
                            (concat (when icon (funcall icon-formatter icon))
                                    (funcall label-formatter label)
                                    (when state (funcall state-formatter state))))
        :label-formatter pg/hass-dash-light-label-formatter
        :state-formatter pg/hass-dash-light-state-formatter
        :icon-formatter pg/hass-dash-light-icon-formatter))))

  (setq pg/hass-dash-group-desktop
    '("Desktop" .
      (("switch.desktop"
          :label "Turn "
          :confirm (lambda (entity-id)
                     (if (hass-switch-p entity-id)
                         (y-or-n-p "Turn off? ")
                         t))
          :state-formatter (lambda (state) (if (string= "off" state) "on" "off")))
       ("sensor.desktop_cpu"
          :label "CPU"
          :icon nil
          :service nil
          :hide-fn pg/hide-unavailable
          :state-formatter pg/percent-suffix)
       ("sensor.desktop_ram"
          :label "MEM"
          :icon nil
          :service nil
          :hide-fn pg/hide-unavailable
          :state-formatter pg/percent-suffix))))

  (setq pg/hass-dash-group-framework
    '("Framework" .
      (("switch.framework_mqtt"
          :label "Framework"
          :widget-formatter pg/laptop-toggle-widget-formatter
          :confirm (lambda (entity-id)
                     (if (hass-switch-p entity-id)
                         (y-or-n-p "Turn off? ")
                         t)))
       ("sensor.framework_battery0"
          :label "BAT"
          :icon nil
          :service nil
          :hide-fn pg/hide-unavailable
          :state-formatter pg/percent-suffix)
       ("sensor.framework_cpu"
          :label "CPU"
          :icon nil
          :service nil
          :hide-fn pg/hide-unavailable
          :state-formatter pg/percent-suffix)
       ("sensor.framework_ram"
          :label "MEM"
          :icon nil
          :hide-fn pg/hide-unavailable
          :state-formatter pg/percent-suffix))))

  (setq pg/hass-dash-group-laptopbig
    '("LaptopBig" .
      (("switch.laptopbig_mqtt"
          :label "LaptopBig"
          :confirm (lambda (entity-id)
                     (if (hass-switch-p entity-id)
                         (y-or-n-p "Turn off? ")
                         t))
          :widget-formatter pg/laptop-toggle-widget-formatter)
       ("sensor.laptopbig_battery0"
          :label "BAT"
          :icon nil
          :service nil
          :hide-fn pg/hide-unavailable
          :state-formatter pg/percent-suffix)
       ("sensor.laptopbig_cpu"
          :label "CPU"
          :icon nil
          :service nil
          :hide-fn pg/hide-unavailable
          :state-formatter pg/percent-suffix)
       ("sensor.laptopbig_ram"
          :label "MEM"
          :icon nil
          :service nil
          :hide-fn pg/hide-unavailable
          :state-formatter pg/percent-suffix))))

  (setq pg/hass-dash-group-test
    '("Test" .
      (("input_boolean.hass_mode_test")
       ("input_boolean.hass_mode_test"
          :label "Turn off Hass mode test"
          :confirm t
          :service "input_boolean.turn_off"
          :state nil)
       ("scene.test_scene"
          :state nil))))

  (setq pg/hass-dash-group-phone
    '("Phone" .
       (("device_tracker.oneplus_7t_pro"
         :label "Location")
        ("sensor.oneplus_7t_pro_media_session"
         :label "Media")
        ("sensor.oneplus_7t_pro_phone_state"
         :label "Call")
        ("sensor.oneplus_7t_pro_battery_level"
         :label "BAT"
         :state-formatter
         (lambda (state)
           (concat " " (propertize (concat state "%")
                        'face 'all-the-icons-purple))))
        ("sensor.oneplus_7t_pro_battery_state"
         :label ""
         :icon nil
         :state-formatter (lambda (state) state)))))

  (setq pg/hass-dash-group-vacuum
   '("Vacuum" .
     (("vacuum.valetudo_vacuum"
         :label "State")
      ("vacuum.valetudo_vacuum"
         :label "Clean"
         :state nil)
      ("vacuum.valetudo_vacuum"
         :label "Return to base"
         :service "vacuum.return_to_base"
         :state nil)
      ("vacuum.valetudo_vacuum"
         :label "Locate"
         :service "vacuum.locate"
         :state nil))))

  (setq hass-dash-layout '(pg/hass-dash-group-light
                           pg/hass-dash-group-desktop
                           pg/hass-dash-group-framework
                           pg/hass-dash-group-laptopbig
                           pg/hass-dash-group-phone
                           pg/hass-dash-group-vacuum
                           pg/hass-dash-group-test))

  ;; An automation just to "eat my own dogfood".
  ;; Changes Emacs theme based on the state of my bedroom light.
  (add-to-list 'hass-tracked-entities "switch.bedroom_light")
  (setq pg/hass-original-theme current-theme)
  (add-hook 'hass-entity-state-changed-functions
    (lambda (entity-id)
      (when (equal entity-id "switch.bedroom_light")
            (if (hass-switch-p entity-id)
                (set-theme 'modus-operandi)
              (set-theme pg/hass-original-theme)))))

  (hass-websocket-mode t)

  :config
  (pg/leader
   :states 'normal
   "a d" #'(hass-dash-open :wk "dashboard")))

(provide 'pg-hass)
