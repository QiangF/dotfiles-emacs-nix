;;; --- -*- lexical-binding: t; -*-
(require 'pg-apps)

(when (daemonp)
  (require 'pg-daemon))

;; Load system-specific modules (hostname)
(cond ((string= "desktop" (system-name))
       (require 'pg-desktop))
      ((string= "framework" (system-name))
       (require 'pg-framework)))

(provide 'pg-system-specific)
