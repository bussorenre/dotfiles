;; パッケージ管理の初期化
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)

;; 分割した設定ファイルの読み込み
(setq load-path
      (append '(
                "~/.emacs.d/conf"
                ) load-path))

(load "helm-init")
(load "ggtags-init")
(load "helm-gtags-init")
(load "tabber-init")

;; 日本語などの設定
(set-language-environment 'Japanese)    ; 日本語環境
(set-default-coding-systems 'utf-8-unix)    ; UTF-8 が基本
(set-terminal-coding-system 'utf-8-unix)    ; emacs -nw も文字化けしない
(setq default-file-name-coding-system 'utf-8)
(setq default-process-coding-system '(utf-8 . utf-8))
(prefer-coding-system 'utf-8-unix)


;; メニューバーを消す
(if window-system (menu-bar-mode 1) (menu-bar-mode -1))


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


;; company
(require 'company)
(global-company-mode)
(setq company-idle-delay 0.1)
(setq company-minimum-prefix-length 2)
(setq company-selection-wrap-around t)


(defun company--insert-candidate2 (candidate)
  (when (> (length candidate) 0)
    (setq candidate (substring-no-properties candidate))
    (if (eq (company-call-backend 'ignore-case) 'keep-prefix)
	(insert (company-strip-prefix candidate))
      (if (equal company-prefix candidate)
	  (company-select-next)
	(delete-region (- (point) (length company-prefix)) (point))
	(insert candidate))
      )))

(defun company-complete-common2 ()
  (interactive)
  (when (company-manual-begin)
    (if (and (not (cdr company-candidates))
	     (equal company-common (car company-candidates)))
	(company-complete-selection)
      (company--insert-candidate2 company-common))))

(define-key company-active-map [tab] 'company-complete-common2)
(define-key company-active-map [backtab] 'company-select-previous) ; おまけ


;; package: dtrt-indent
(require 'dtrt-indent)
(dtrt-indent-mode 1)
(setq dtrt-indent-verbosity 0)

;; package: undo-tree
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

;; Compilation
(global-set-key (kbd "<f5>")
		(lambda ()
		  (interactive)
		  (setq-local compilation-read-command nil)
		  (call-interactively 'compile)))

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

;; =================================================
;; golang-mode 
;; =================================================
(require 'go-mode)
(add-hook 'go-mode-hook
	  '(lambda ()
       	    (setq indent-tabs-mode nil)    ; タブを利用しない
	    (setq c-basic-offset 4)        ; tabサイズを4にする
	    (setq tab-width 4)
	    ))


;; =================================================
;; emmet-mode 
;; =================================================
(require 'emmet-mode)
(add-hook 'sgml-mode-hook 'emmet-mode) ;; マークアップ言語全部で使う
(add-hook 'css-mode-hook  'emmet-mode) ;; CSSにも使う
(add-hook 'emmet-mode-hook (lambda () (setq emmet-indentation 2))) ;; indent はスペース2個
(eval-after-load "emmet-mode"
  '(define-key emmet-mode-keymap (kbd "C-j") nil)) ;; C-j は newline のままにしておく
;; (keyboard-translate ?\C-i ?\H-i) ;;C-i と Tabの被りを回避
;;(define-key emmet-mode-keymap (kbd "H-i") 'emmet-expand-line) ;; C-i で展開

		   
;; YASnippet
(require 'yasnippet)
(yas-global-mode 1)
(setq yas-also-auto-indent-first-line t)


;; sr-speedbar
(require 'sr-speedbar nil t)
(setq sr-speedbar-right-side nil)
(setq speedbar-directory-unshown-regexp "^\\(CVS\\|RCS\\|SCCS\\|\\.\\.*$\\)\\'")
(global-set-key (kbd "C-t") 'sr-speedbar-toggle)
(global-unset-key (kbd "M-t"))


