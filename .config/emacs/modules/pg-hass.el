;;; --- -*- lexical-binding: t; -*-
(require 'pg-theme)

(use-package hass
  :straight t
  :after pass
  :init
  (setq hass-host "homeassistant.lan")
  (setq hass-insecure t)
  (setq hass-apikey (auth-source-pass-get 'secret "home/hass/emacs-apikey"))
  (pg/leader
    :states 'normal
    "a" #'(:ignore t :wk "automation")
    "a c" #'(hass-call-service :wk "Call service")
    "a d" #'(hass-dash-open :wk "Call service"))

  (add-to-list 'popper-reference-buffers "^\\*hass-dash.*\\*$")
  (add-to-list 'popper-reference-buffers 'hass-dash-mode)
  
  (setq hass-dash-layouts '((default . ((hass-dash-group :title "Desktop" :format "%t\n%v\n"
                                                         (hass-dash-toggle :entity-id "switch.desktop" :confirm t)
                                                         (hass-dash-button :entity-id "media_player.mpd" :label "MEDIA")
                                                         (hass-dash-state :entity-id "sensor.desktop_cpu" :label "CPU")
                                                         (hass-dash-state :entity-id "sensor.desktop_ram" :label "RAM"))
                                        (hass-dash-group :title "Laptop" :format "%t\n%v\n"
                                                         (hass-dash-toggle :entity-id "switch.laptopbig" :label "Power" :confirm t)
                                                         (hass-dash-state :entity-id "sensor.laptopbig_cpu" :label "CPU")
                                                         (hass-dash-state :entity-id "sensor.laptopbig_ram" :label "RAM"))
                                        (hass-dash-group :title "Phone" :format "%t\n%v\n"
                                                         (hass-dash-state :entity-id "sensor.pixel_7_pro_battery_level" :label "Battery" :format "%t: %v%%\n")
                                                         (hass-dash-state :entity-id "sensor.pixel_7_pro_battery_state" :label "Bat state?")
                                                         (hass-dash-state :entity-id "sensor.pixel_7_pro_phone_state" :label "Phone")
                                                         (hass-dash-state :entity-id "sensor.pixel_7_pro_media_session" :label "Media"))
                                        (hass-dash-group :title "TV" :format "%t\n%v\n"
                                                         (hass-dash-button :entity-id "media_player.shield" :icon "" :label " Toggle"))
                                        (hass-dash-group :title "Bedroom" :format "%t\n%v\n"
                                                         (hass-dash-toggle :entity-id "light.bedroom")
                                                         (hass-dash-toggle :entity-id "fan.bedroom"))
                                        (hass-dash-group :title "Vacuum"
                                                         (hass-dash-state :entity-id "vacuum.valetudo_vacuum"
                                                                          :format "%v\n")
                                                         (hass-dash-button :entity-id "vacuum.valetudo_vacuum"
                                                                           :service "vacuum.start"
                                                                           :format "%[%t%]\n"
                                                                           :label "Clean")
                                                         (hass-dash-button :entity-id "vacuum.valetudo_vacuum"
                                                                           :service "vacuum.return_to_base"
                                                                           :format "%[%t%]\n"
                                                                           :label "Return to base")
                                                         (hass-dash-button :entity-id "vacuum.valetudo_vacuum"
                                                                           :service "vacuum.locate"
                                                                           :format "%[%t%]\n"
                                                                           :label "Locate"))))
                            (testing . ((hass-dash-group :title "" :format "%v"
                                                         (hass-dash-toggle :entity-id "input_boolean.hass_mode_test")
                                                         (hass-dash-button :entity-id "scene.test_scene"))))
                            (broken . ((hass-dash-group :title "Group 1"
                                                        (hass-dash-toggle :entity-id "input_boolean.hass_mode_test")
                                                        (hass-dash-group :title "Group 1 Subgroup 1"
                                                                         (hass-dash-toggle :entity-id "input_boolean.hass_mode_test"))
                                                        (hass-dash-group :title "Group 1 Subgroup 2"
                                                                         (hass-dash-toggle :entity-id "input_boolean.hass_mode_test")))
                                       (hass-dash-group :title "Group 2"
                                                        (hass-dash-toggle :entity-id "input_boolean.hass_mode_test")
                                                        (hass-dash-group :title "Group 2 Subgroup 1"
                                                                         (hass-dash-toggle :entity-id "input_boolean.hass_mode_test"))
                                                        (hass-dash-group :title "Group 2 Subgroup 2"
                                                                         (hass-dash-toggle :entity-id "input_boolean.hass_mode_tes")))))))

  (defun hass-capf (&optional interactive)
    (interactive (list t))
    (if interactive
        (let ((completion-at-point-functions (list #'hass-capf)))
          (completion-at-point))
      (let ((bounds (bounds-of-thing-at-point 'symbol)))
        (list (car bounds)
              (cdr bounds)
              (mapcar #'car hass--available-entities)))))

  :config
  ;; An automation just to "eat my own dogfood".
  ;; Changes Emacs theme based on the state of my bedroom light.
  (add-to-list 'hass-tracked-entities "switch.bedroom_light")
  (setq pg/hass-original-theme current-theme)
  (add-hook 'hass-entity-state-changed-functions
            (lambda (entity-id)
              (when (equal entity-id "switch.bedroom_light")
                (if (hass-switch-p entity-id)
                    (set-theme 'tsdh-light)
                  (set-theme pg/hass-original-theme)))))
  (hass-ensure))

(provide 'pg-hass)
