(when (daemonp)
(use-package exec-path-from-shell
:straight t
:init
(exec-path-from-shell-initialize)))

(setq native-comp-async-report-warnings-errors nil)

(cond ((string= "framework" (system-name))
    (org-babel-load-file "~/.emacs.profiles.d/purplg/framework.org"))
    ((string= "desktop" (system-name))
    (org-babel-load-file "~/.emacs.profiles.d/purplg/desktop.org")))

(defun save-excursion-wrapper (inner &rest args)
(save-excursion
    (funcall inner)))

(defalias 'after! 'with-eval-after-load)

(setq frame-title-format "PurplEmacs")

(setq ring-bell-function 'ignore)

(setq scroll-conservatively 101)
