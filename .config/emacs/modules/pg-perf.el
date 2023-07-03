;;; --- -*- lexical-binding: t; -*-

;; Doom emacs performance tweaks
(setq gc-cons-threshold 10000000) ; 2^61 bytes
(setq gc-cons-percentage 0.1)
(setq load-prefer-newer noninteractive)
(setq ad-redefinition-action 'accept)
(setq highlight-nonselected-windows nil)
(setq fast-but-imprecise-scrolling t)
(setq idle-update-delay 1.0)
(setq redisplay-skip-fontification-on-input t)
(setq frame-inhibit-implied-resize t)
(setq-default bidi-display-reordering 'left-to-right)
(setq-default bidi-paragraph-direction 'left-to-right)
(setq-default cursor-in-non-selected-windows nil)

(provide 'pg-perf)
