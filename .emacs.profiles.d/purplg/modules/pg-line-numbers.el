;;; --- -*- lexical-binding: t; -*-

(setq-default display-line-numbers-type 'visual)
(setq-default display-line-numbers-current-absolute t)
(add-hook 'prog-mode-hook #'display-line-numbers-mode)
(with-eval-after-load 'org-mode
  (add-hook 'org-mode-hook #'display-line-numbers-mode))

(provide 'pg-line-numbers)
