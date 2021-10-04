;; Doom emacs performance tweaks
(setq gc-cons-threshold most-positive-fixnum ; 2^61 bytes
      gc-cons-percentage 0.6)
(setq load-prefer-newer noninteractive)
(setq ad-redefinition-action 'accept)
(setq-default bidi-display-reordering 'left-to-right
              bidi-paragraph-direction 'left-to-right)
(setq-default cursor-in-non-selected-windows nil)
(setq highlight-nonselected-windows nil)
(setq fast-but-imprecise-scrolling t)
(setq idle-update-delay 1.0)
(setq redisplay-skip-fontification-on-input t)
(setq frame-inhibit-implied-resize t)

(provide 'pg-perf)