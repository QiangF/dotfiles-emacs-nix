(setq no-byte-compile t)

(require 'pg-config (file-truename (expand-file-name "pg-config.el" user-emacs-directory)))
(require 'pg-perf)
(require 'pg-keybinds)
(require 'pg-interface)
(require 'pg-editing)
(require 'pg-apps)
(require 'pg-system-specific)
