(set-language-environment 'Japanese)    ; 日本語環境
(set-default-coding-systems 'utf-8-unix)    ; UTF-8 が基本
(set-terminal-coding-system 'utf-8-unix)    ; emacs -nw も文字化けしない
(setq default-file-name-coding-system 'utf-8)
(setq default-process-coding-system '(utf-8 . utf-8))
(prefer-coding-system 'utf-8-unix)


(setq auto-save-timeout 1)   ; 自動保存する間隔。秒。
(setq auto-save-interval 10) ; 300打鍵ごとに自動保存
(setq create-lockfiles nil)  ; ロックファイルを作成しない。


;; 対応するカッコを強調表示
(show-paren-mode t)

;; 時間も表示させる。
(display-time)

;; 行番号を常に表示させる
(global-linum-mode)
(setq linum-format "%4d ")

;; テーマを設定する
(load-theme 'manoj-dark t)


;; キーバインドの変更
(keyboard-translate ?\C-h ?\C-?)

;; Cmd をメタキーに
(when (eq system-type 'darwin)
    (setq ns-command -modifier (quote meta))
    )

;; パッケージ管理の初期化
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)


