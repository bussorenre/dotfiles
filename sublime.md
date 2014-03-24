* local settings for Sublime Text 3 

This doc includes what I changed and wrote for sublime text settings.


** Installed Packages
*** management sublime text
- Package Control
- monokai extended



*** HTML5 / CSS3
- Emmet






{
    // ミニマップの見てる場所を常に表示させる。
    "always_show_minimap_viewport": true,

    // vim モードを有効にする。
    "ignored_packages": [],

    // タブをスペースに変換する。少々めんどい。状況（プロジェクト）によって変えたし。
    "translate_tabs_to_spaces": true,

    // フォントサイズ１２（ギリギリ視認できる範囲
    "font_size": 12,

    // margin 2してみた。意外と見やすいかもしれない
    "margin": 2,

    // マウスオーバー時にのみ行番号の三角形（隠す隠さない）を表示
    "fade_fold_buttons": false,

    // 行頭に線を表示
    "rulers": [0],

    // 右端待で行ったら回りこませる……。これ地味にどうしようか悩み中
    "word_wrap": true,

    // ミニマップに枠を表示
    "draw_minimap_border": true,

    // キャレットのスタイルを変更
    "caret_style": "blink",

    // インデントのガイドを行う。超便利！！ｗ
    "indent_guide_options": ["draw_active", "draw_normal"],

    //
    // User Interfaces
    //

    // 変更されたファイルのタブを光らせる。
    "highlight_modified_tabs": true,

    // ばつボタンを表示する。
    "show_tab_close_buttons": false,

    // エンコーディングを表示
    "show_encoding": true,

    // ウィンドウが空になったらそのウィンドウを閉じる
    "close_windows_when_empty": true,


    // phoenixの設定

    "theme": "Phoenix Dark.sublime-theme",
    "phoenix_color_green": true,
    "phoenix_solid_current_tab": true,
    "phoenix_dirty_bottom_bar": true,
    "phoenix_dirty_bottom_bar_green": true,

    // sodaの設定
    /*
    "theme": "Soda Dark 3.sublime-theme",
    "soda_classic_tabs": true,pinstall
    "soda_folder_icons": true,
    */

    // カラースキーマ（monokai Extended をとりあえず採用）
    "color_scheme": "Packages/Monokai Extended/Monokai Extended.tmTheme",



//==============================================================================================
    // 使いたくても使いづらい設定たち
//==============================================================================================

    // 物凄くtrueにしたいけど、日本語が全部ダメになる。日本語をどうするか。
    "dictionary": "Packages/Language - English/en_US.dic",
    "spell_check": false,

    // 現在編集している行にハイライトを入れる。
    // 下線だけでいい気がする。
    "highlight_line": false


}