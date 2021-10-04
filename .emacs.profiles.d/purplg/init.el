;; Keep config directory clean
(setq user-emacs-directory (expand-file-name "~/.cache/emacs/")
      url-history-file (expand-file-name "url/history" user-emacs-directory))

(defconst pg/config-dir (expand-file-name "~/.emacs.profiles.d/purplg/"))
(defconst pg/module-dir (expand-file-name "modules/" pg/config-dir))
(add-to-list 'load-path pg/module-dir)

(require 'pg-config)
(require 'pg-perf)
(require 'pg-basics)
(require 'pg-evil)
(require 'pg-interface)
(require 'pg-editing)
(require 'pg-apps)
(require 'pg-system-specific)
