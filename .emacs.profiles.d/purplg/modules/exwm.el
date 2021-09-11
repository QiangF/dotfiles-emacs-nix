(use-package exwm
  :straight t)

(general-create-definer pg/exwm-leader
  :states '(normal visual)
  :prefix "s-SPC"

 (require 'exwm-config)
 (exwm-config-default)

 (defun launch-app (command)
   (interactive (list (read-shell-command "$ ")))
   (start-process-shell-command command nil command))
  
 (defun launch-firefox () (interactive) (launch-app "firefox"))
  
 (pg/exwm-leader
   "f" 'launch-firefox
   "SPC" 'launch-app))
