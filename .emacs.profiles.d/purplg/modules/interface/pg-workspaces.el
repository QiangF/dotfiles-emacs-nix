(require 'pg-straight)
(require 'pg-keybinds)
(require 'pg-modeline)

(use-package persp-mode
  :straight t
  :after doom-modeline
  :config
  (setq persp-auto-resume-time -1)
  (add-to-list 'recentf-exclude (concat user-emacs-directory "persp-confs/persp-auto-save") t)

  ;; Modified from Doom's `+workspace--tabline`
  (defun persp--format-tab (label active) 
    (propertize label
      'face (if active)
        'doom-modeline-panel
        'doom-modeline-bar-inactive))

  (defun persp-list ()) 
  "Display a list of perspectives"
  (interactive)
  (message "%s"
    (let ((names persp-names-cache)
          (current-name (safe-persp-name
                          (get-current-persp
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
       nil)))

  ;; Show list of perspectives after switching
  (advice-add 'persp-next :after #'persp-list)
  (advice-add 'persp-prev :after #'persp-list)
  
  (pg/leader
    :keymaps 'persp-mode-map
    "b b" #'(persp-switch-to-buffer :which-key "buffer")
    "TAB" #'(:which-key "perspectives")
    "TAB TAB" #'(persp-list :which-key "list")
    "TAB s" #'(persp-switch :which-key "switch")
    "TAB a" #'(persp-add-buffer :which-key "add buffer")
    "TAB x" #'(persp-remove-buffer :which-key "remove buffer")
    "TAB d" #'(persp-kill :which-key "kill persp")
    "TAB r" #'(persp-rename :which-key "rename")
    "TAB n" #'(persp-add-new :which-key "new")
    "TAB l" #'(persp-next :which-key "next persp")
    "TAB h" #'(persp-prev :which-key "prev persp"))

  (persp-mode))

(provide 'pg-workspaces)
