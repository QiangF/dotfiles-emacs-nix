;;; --- -*- lexical-binding: t; -*-
(require 'pg-aliases)

;; Try to load system-specific modules (hostname)
(pg/try-load-file (file-name-concat "system-specific/"
                                    (file-name-with-extension (system-name) ".el")))

;; local.el is an untracked / .gitignored file. Load it if it exists
(pg/try-load-file "local.el")
