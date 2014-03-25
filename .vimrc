" これが私の.vimrc になるのだよ！！
" 思いついたら徐々に改善していきましょう！！


"=== 表示設定 ==="
syntax on			" コードの色分け

set number			" 行番号を表示する
set ruler 			" ルーラーを表示する
set title			" 編集中のファイル名を表示
set showmatch		" 括弧入力時の対応する括弧を表示
set showcmd			" コマンドをステータス行に表示？
set cmdheight=1		" コマンド行の高さ（下から1行目
set scrolloff=500	" スクロールバーの位置
set cursorline		" カーソルラインのアンダーバー


"=== ステータスラインの設定  ==="
set laststatus=2	" ステータスラインの表示場所を決める
set statusline=[%L]\ %t\ %y%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}%r%m%=%c:%l/%L


"=== インデント設定 ==="
set autoindent		" 自動でインデンテーションする
set shiftwidth=4	" タブ幅４
set tabstop=4		" タブ幅４
set expandtab		" タブをスペースに変える



"=== カラースキーマ ==="
colorscheme molokai



"=== 以下vimrcのコマンド練習==="


