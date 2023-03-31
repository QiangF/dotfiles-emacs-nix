;;; --- -*- lexical-binding: t; -*-
(require 'pg-apps)
(require 'pg-aliases)

;; Load system-specific modules (hostname)
(let ((system-dir (expand-file-name "system-specific/" pg/config-dir)))
  (pg/load-file (concat (system-name) ".el") system-dir))

;; local.el is an untracked / .gitignored file. Load it if it exists
(pg/load-file "local.el")

(provide 'pg-system-specific)
