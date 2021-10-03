;; Keep config directory clean
(setq user-emacs-directory (expand-file-name "~/.cache/emacs/")
      url-history-file (expand-file-name "url/history" user-emacs-directory))

(defconst pg/config-dir (expand-file-name "~/.emacs.profiles.d/purplg/"))
(defconst pg/module-dir (expand-file-name "modules/" pg/config-dir))
(add-to-list 'load-path pg/module-dir)

(require 'pg-straight)
(require 'pg-basics)
(require 'pg-keybinds)
(require 'pg-interface)
(require 'pg-editing)
(require 'pg-apps)

;; Load system-specific modules (hostname)
(cond ((string= "desktop" (system-name))
       (require 'pg-desktop))
      ((string= "framework" (system-name))
       (require 'pg-framework)))

(defun pg/compile-modules ()
  (interactive)
  (let ((files (directory-files pg/module-dir t ".el$")))
    (dolist (file files)
      (byte-compile-file file))))
