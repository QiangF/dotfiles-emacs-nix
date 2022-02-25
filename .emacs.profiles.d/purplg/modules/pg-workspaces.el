;;; --- -*- lexical-binding: t; -*-
(require 'pg-keybinds)
(require 'pg-modeline)

(use-package persp-mode
  :straight t
  :after doom-modeline
  :config
  (setq persp-auto-resume-time -1)
  (add-to-list 'recentf-exclude (concat user-emacs-directory "persp-confs/persp-auto-save") t)

  (defun project-switch-with-workspace ()
    (interactive)
    (call-interactively #'persp-switch-to-new)
    (call-interactively #'project-switch-project))

  (defun persp-switch-to-new ()
    (interactive)
    (persp-switch
      (persp-name
        (call-interactively #'persp-add-new))))

  ;; Modified from Doom's `+workspace--tabline`
  (defun persp--format-tab (label active) 
    (propertize label
      'face (if active
                'doom-modeline-panel
                'doom-modeline-bar-inactive)))

  (defun persp-list () 
    "Display a list of perspectives"
    (interactive)
    (message "%s"
      (let ((names persp-names-cache)
            (current-name (safe-persp-name (get-current-persp
                                             (selected-frame)
                                             (selected-window)))))
        (mapconcat
           #'identity
           (cl-loop for name in names
                    for i to (length names)
                    collect
                    (persp--format-tab
                      (format " %d:%s " (1+ i) name)
                      (equal current-name name)))
           nil))))

  ;; Show list of perspectives after switching
  (advice-add 'persp-next :after #'persp-list)
  (advice-add 'persp-prev :after #'persp-list)
  
  (pg/leader
   :keymaps 'persp-mode-map
   "b b" #'(persp-switch-to-buffer :wk "buffer")
   "TAB" #'(:wk "perspectives")
   "TAB TAB" #'(persp-list :wk "list")
   "TAB s" #'(persp-switch :wk "switch")
   "TAB a" #'(persp-add-buffer :wk "add buffer")
   "TAB x" #'(persp-remove-buffer :wk "remove buffer")
   "TAB d" #'(persp-kill :wk "kill persp")
   "TAB r" #'(persp-rename :wk "rename")
   "TAB n" #'(persp-switch-to-new :wk "new and switch")
   "TAB N" #'(persp-add-new :wk "new")
   "TAB p" #'(project-switch-with-workspace :wk "new with project")
   "TAB l" #'(persp-next :wk "next persp")
   "TAB h" #'(persp-prev :wk "prev persp"))

  (add-hook 'after-init-hook
   (lambda () (persp-switch (persp-name (persp-add-new "Session")))))

  (persp-mode))

(provide 'pg-workspaces)
