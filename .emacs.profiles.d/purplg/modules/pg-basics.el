(require 'pg-straight)

(defalias 'after! 'with-eval-after-load)

(setq native-comp-async-report-warnings-errors nil
      ring-bell-function 'ignore
      scroll-conservatively 101)

(provide 'pg-basics)
