;;; --- -*- lexical-binding: t; -*-

(require 'pg-theme)

(use-package hass
  :after pass
  :elpaca (:host github :repo "purplg/hass" :branch "dev")
  :functions hass-mode
  :init
  (setq hass-host "homeassistant.lan")
  (setq hass-apikey (auth-source-pass-get 'secret "home/hass/emacs-apikey"))
  (setq hass-insecure t)
  (setq hass-dash-update-delay 0.1)
  (setq hass--debug t)
  (setq hass--debug-ignore '("EVENT" "HTTP"))

  (defun pg/toggle-office-lights ()
    (interactive)
    (hass-call-service-with-payload
     "light.toggle"
     '((entity_id . "light.office")
       (transition . "3")
       (brightness . "100"))))

  (defvar pg/away nil)
  (defvar pg/away-light nil)
  (defun pg/away-turn-on ()
    (setq pg/away t)
    (message "Enabled away")
    (hass-call-service-with-payload
     "input_number.set_value"
     `((entity_id . "input_number.target_brightness")
       (value . ,pg/away-light))))
  
  (defun pg/away-turn-off ()
    (setq pg/away nil)
    (message "Disable away")
    (hass-call-service-with-payload
     "input_number.set_value"
     '((entity_id . "input_number.target_brightness")
       (value . "0"))))

  (defun pg/toggle-away ()
    (interactive)
    (unless pg/away-light
      (setq pg/away-light (or (hass-attribute-of "light.office"
                                                 'brightness)
                              255)))
    (if pg/away
        (pg/away-turn-off)
      (pg/away-turn-on)))

  :config
  (evil-define-key* 'normal 'global
    (kbd "<leader> a") (make-sparse-keymap)
    (kbd "<leader> a a") #'("Away" . pg/toggle-away)
    (kbd "<leader> a c") #'("Call service" . hass-call-service)
    (kbd "<leader> a l") #'("Toggle lights" . pg/toggle-office-lights)
    (kbd "<leader> a d") #'("Call service" . hass-dash-open)
    (kbd "<leader> a /") #'("Debug log" . (lambda () (interactive) (pop-to-buffer (hass--debug-buffer)))))

  (add-to-list 'popper-reference-buffers "^\\*hass-dash.*\\*$")
  (add-to-list 'popper-reference-buffers 'hass-dash-mode)

  (defun hass-capf (&optional interactive)
    (interactive (list t))
    (if interactive
        (let ((completion-at-point-functions (list #'hass-capf)))
          (completion-at-point))
      (let ((bounds (bounds-of-thing-at-point 'symbol)))
        (list (car bounds)
              (cdr bounds)
              (mapcar #'car hass--available-entities)))))

  (evil-define-key*
    '(normal insert)
    'global
    (kbd "M-a") #'hass-call-service)

  (with-eval-after-load 'hass-dash
    ;; (hass-dash-load-layout
    ;;  (file-name-concat pg/config-dir
    ;;                    "hass-dash-layouts.el"))
    (evil-define-key* 'normal hass-dash-mode-map
      (kbd "h") #'hass-dash-slider-decrease
      (kbd "l") #'hass-dash-slider-increase))

  (hass-dash-load-layout (file-name-concat pg/config-dir "hass-dash-layouts.el"))

  (hass-mode 1))

(provide 'pg-hass)
