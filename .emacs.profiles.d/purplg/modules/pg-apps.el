(add-to-list 'load-path (expand-file-name "apps/" pg/module-dir))

(require 'pg-org)
(require 'pg-pass)
;;(require 'pg-irc)
(require 'pg-telegram)
(require 'pg-term)

(provide 'pg-apps)
