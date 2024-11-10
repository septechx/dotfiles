#! /bin/zsh

SESSIONNAME="ziglings"
DIR="$HOME/projects/learn/zig/exercises/exercises/"
tmux has-session -t $SESSIONNAME &>/dev/null

if [ $? != 0 ];              then
  tmux new-session -s $SESSIONNAME -c $DIR -d
  tmux send-keys -t $SESSIONNAME 'vim' C-m
  tmux new-window -t $SESSIONNAME -c $DIR
fi

tmux attach -t $SESSIONNAME
