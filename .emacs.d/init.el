(set-language-environment 'Japanese)    ; 日本語環境
(set-default-coding-systems 'utf-8-unix)    ; UTF-8 が基本
(set-terminal-coding-system 'utf-8-unix)    ; emacs -nw も文字化けしない
(setq default-file-name-coding-system 'utf-8)
(setq default-process-coding-system '(utf-8 . utf-8))
(prefer-coding-system 'utf-8-unix)


;; ロックファイル / バックアップファイルを作成しない
(setq create-lockfiles nil)
(setq make-backup-files nil)
(setq delete-auto-save-files t)


;; 対応するカッコを強調表示
(show-paren-mode t)

;; 時間も表示させる。
(display-time)

;; 行番号を常に表示させる
(require 'linum)
(global-linum-mode t)
(setq linum-format "%4d ")

;; 現在行を目立たせる
(setq hl-line-face 'underline)
(global-hl-line-mode)

;; テーマを設定する
(load-theme 'manoj-dark t)

;; キーバインドの変更
(keyboard-translate ?\C-h ?\C-?)

;; Cmd をメタキーに
(when (eq system-type 'darwin)
    (setq ns-command-modifier (quote meta)))

;; パッケージ管理の初期化
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)




;; ==================================================
;; Auto Complete
;; ==================================================
(require 'auto-complete-config)
(ac-config-default)
(ac-set-trigger-key "TAB")
(global-auto-complete-mode t)


;; ==================================================
;; Undo-tree
;; ==================================================
(require 'undo-tree)
(global-undo-tree-mode t)
(global-set-key (kbd "M-/") 'undo-tree-redo)

;; ==================================================
;; tramp / ssh remote file open
;; ==================================================
(require 'tramp)
(setq tramp-default-method "ssh")
(add-to-list 'tramp-default-proxies-alist
	     '(nil "\\'root'" "/ssh:%h:"))
(add-to-list 'tramp-default-proxies-alist
	     '("localhost" nil nil))
(add-to-list 'tramp-default-proxies-alist
	     '((regexp-quote (system-name)) nil nil))




;; =================================================
;; cc-mode 
;; =================================================
(require 'cc-mode)
(add-hook 'c-mode-common-hook
	  '(lambda ()
	    (setq c-default-style "linux") ; Linux Kernel のコーディング規約に従う
	    (setq indent-tabs-mode nil)    ; タブを利用しない
	    (setq c-basic-offset 4)        ; tabサイズを4にする
	    (setq tab-width 4)
	    (define-key c-mode-map (kbd "<f6>") 'man)
	    )
	  )


;; =================================================
;; python-mode 
;; =================================================
(require 'python)
(defun python-shell-parse-command ()
  "Return the string used to execute the inferior Python process."
  "python3 -i"
    )

(add-hook 'python-mode-hook
	  '(lambda ()
	     (setq indent-tabs-mode nil)
	     (setq indent-level 4)
	     (setq python-indent 4)
	     (define-key python-mode-map "\C-m" 'newline-and-indent)
	     (setq tab-width 4)))
		   



;;


(require 'gtags)
(global-set-key "\M-t" 'gtags-find-tag)
(global-set-key "\M-r" 'gtags-find-rtag)
(global-set-key "\M-s" 'gtags-find-symbol)
(global-set-key "\C-t" 'gtags-pop-stack)


(require 'ggtags)
(add-hook 'c-mode-common-hook
	  (lambda ()
	    (when (drived-mode-p 'c-mode 'c++-mode)
	      (ggtags-mode 1))))

(define-key ggtags-mode-map (kbd "C-c g s") 'ggtags-find-other-symbol)
(define-key ggtags-mode-map (kbd "C-c g h") 'ggtags-view-tag-history)
(define-key ggtags-mode-map (kbd "C-c g r") 'ggtags-find-reference)
(define-key ggtags-mode-map (kbd "C-c g f") 'ggtags-find-file)
(define-key ggtags-mode-map (kbd "C-c g c") 'ggtags-create-tags)
(define-key ggtags-mode-map (kbd "C-c g u") 'ggtags-update-tags)

(define-key ggtags-mode-map (kbd "M-,") 'pop-tag-mark)




