(require 'pg-straight)

(defalias 'after! 'with-eval-after-load)

(setq native-comp-async-report-warnings-errors nil)
(setq ring-bell-function 'ignore)
(setq scroll-conservatively 101)

(provide 'pg-basics)
