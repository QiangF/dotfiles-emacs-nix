(setq-default display-line-numbers-type 'visual
              display-line-numbers-current-absolute t)
(hook! '(prog-mode-hook org-mode-hook) #'display-line-numbers-mode)

(provide 'pg-line-numbers)
