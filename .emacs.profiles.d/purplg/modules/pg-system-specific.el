;;; --- -*- lexical-binding: t; -*-
(require 'pg-config)
(require 'pg-apps)

(add-to-list 'load-path (expand-file-name "system-specific/" pg/module-dir))

(when (daemonp) (require 'pg-daemon))

;; Load system-specific modules (hostname)
(cond ((string= "desktop" (system-name))
       (require 'pg-desktop))
      ((string= "framework" (system-name))
       (require 'pg-framework)))

(provide 'pg-system-specific)
