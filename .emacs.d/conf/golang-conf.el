
;; Goのパスを通す
(add-to-list 'exec-path (expand-file-name "/usr/local/go/bin/"))

;; go get で入れたツールのパスを通す
(add-to-list 'exec-path (expand-file-name "/Users/ryo/.go/bin"))



;; go-mode の有効化
(require 'go-mode)
(require 'company-go)
(add-hook 'go-mode-hook 'company-mode)
(add-hook 'go-mode-hook (lambda()
	       (add-hook 'before-save-hook' 'gofmt-before-save)
	       (local-set-key (kbd "M-.") 'godef-jump)
	       (set (make-local-variable 'company-backends) '(company-go))
	       (company-mode)))
