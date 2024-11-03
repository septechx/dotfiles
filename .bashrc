#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

# Custom below
export EDITOR=nvim

alias vim="nvim"
alias rm="trash"
alias c="clear"

figlet "Nah siesque rili" | lolcat

eval "$(starship init bash)"
eval "$(zoxide init --cmd cd bash)"

# pnpm
export PNPM_HOME="/home/sep/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
