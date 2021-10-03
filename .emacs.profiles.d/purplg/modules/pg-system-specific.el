(add-to-list 'load-path (expand-file-name "system-specific/" pg/module-dir))

;; Load system-specific modules (hostname)
(cond ((string= "desktop" (system-name))
       (require 'pg-desktop))
      ((string= "framework" (system-name))
       (require 'pg-framework)))

(provide 'pg-system-specific)
