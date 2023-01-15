;;; --- -*- lexical-binding: t; -*-
(require 'pg-apps)

(let ((system-dir (expand-file-name "system-specific/" pg/config-dir)))
  (when (daemonp)
    (load-file (expand-file-name "daemon.el" system-dir)))

  ;; Load system-specific modules (hostname)
  (let ((system-config (expand-file-name (concat (system-name) ".el") system-dir)))
    (when (file-exists-p system-config)
      (load-file system-config))))

(let ((local-config (expand-file-name "local.el" pg/config-dir)))
  (when (file-exists-p local-config)
    (load-file local-config)))

(provide 'pg-system-specific)
