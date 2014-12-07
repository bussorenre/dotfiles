#!/bin/bash

user=simakawa-lab
servers=("${user}@192.168.2.231" "${user}@192.168.2.233" "${user}@192.168.2.238")

if [ -n "$SESSION_NAME" ];then
  session=$SESSION_NAME
else
  session=multi-ssh-`date +%s`
fi
window=multi-ssh

### tmuxのセッションを作成
tmux new-session -d -n $window -s $session

### 最初の一枚作る
tmux send-keys "ssh ${servers[0]}" C-m
shift
 

# paneを作成してからssh
for (( i = 1; i < ${#servers[@]}; ++i )) do
  tmux split-window
  tmux select-layout tiled
  tmux send-keys "ssh ${servers[$i]}" C-m
done

### 最初のpaneを選択状態にする
tmux select-pane -t 0

### paneの同期モードを設定
tmux set-window-option synchronize-panes on

### セッションにアタッチ
tmux attach-session -t $session
