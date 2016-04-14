(require 'helm-config)


(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-x b") 'helm-mini)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
;; (global-set-key (kbd "C-h SPC") 'helm-all-mark-rings) :: 謎
;; (global-set-key (kbd "C-c h o") 'helm-occur) ;; 謎






(helm-mode 1)

