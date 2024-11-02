#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

alias vim="nvim"
alias cd="z"
alias rm="trash"
alias c="clear"

eval "$(starship init bash)"
eval "$(zoxide init bash)"
