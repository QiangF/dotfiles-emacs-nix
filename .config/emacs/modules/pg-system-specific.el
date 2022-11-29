;;; --- -*- lexical-binding: t; -*-
(require 'pg-apps)

(when (daemonp)
  (require 'pg-daemon))

;; Load system-specific modules (hostname)
(cond ((string= "desktop" (system-name))
       (require 'pg-desktop))
      ((string= "framework" (system-name))
       (require 'pg-framework)))

(let ((local-config (expand-file-name "local.el" pg/config-dir)))
  (when (file-exists-p local-config)
    (load-file local-config)))

(provide 'pg-system-specific)
