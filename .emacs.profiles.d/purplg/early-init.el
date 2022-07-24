(setq package-enable-at-startup nil)

(defvar current-theme nil)

(defun set-theme (theme-name)
  (setq current-theme theme-name)
  (load-theme current-theme t))

(setq modus-themes-italic-constructs t)
(setq modus-themes-bold-constructs t)
(setq modus-themes-region '(bg-only))
(setq modus-themes-syntax '(green-strings))
(setq modus-themes-paren-match '(bold intense))
(setq modus-themes-mode-line '(borderless accented))
(setq modus-themes-prompts '(intense bold))
(setq modus-themes-org-blocks 'gray-background)
(setq modus-themes-completions '((popup . (accented intense))))
(set-theme 'modus-vivendi)
