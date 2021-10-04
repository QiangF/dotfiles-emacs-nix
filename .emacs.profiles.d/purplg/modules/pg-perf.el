;; Doom emacs performance tweaks
(setq gc-cons-threshold most-positive-fixnum ; 2^61 bytes
      gc-cons-percentage 0.6
      load-prefer-newer noninteractive
      ad-redefinition-action 'accept
      highlight-nonselected-windows nil
      fast-but-imprecise-scrolling t
      idle-update-delay 1.0
      redisplay-skip-fontification-on-input t
      frame-inhibit-implied-resize t)
(setq-default bidi-display-reordering 'left-to-right
              bidi-paragraph-direction 'left-to-right
              cursor-in-non-selected-windows nil)

(provide 'pg-perf)
