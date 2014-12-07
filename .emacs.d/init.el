(set-locale-environment "utf-8")
(setenv "LANG"  "ja_JP.UTF-8")


(add-to-list 'load-path "~/.emacs.d/config/")


(setq auto-save-timeout 1)   ; 自動保存する間隔。秒。
(setq auto-save-interval 10) ; 300打鍵ごとに自動保存
(setq create-lockfiles nil)  ; ロックファイルを作成しない。

;; (require 'auto-save-buffers)
;; (run-with-idle-timer 1.0 t 'auto-save-buffers) ; アイドル1.0秒で保存
