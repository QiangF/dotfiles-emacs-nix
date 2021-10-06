;;; --- -*- lexical-binding: t; -*-
(require 'pg-straight)

(use-package elfeed
  :straight t
  :config
  (setq elfeed-feeds
        '(("https://planet.emacslife.com/atom.xml")
          ("https://protesilaos.com/codelog.xml"))))

(provide 'pg-rss)
