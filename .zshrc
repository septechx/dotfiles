
# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'
zstyle :compinstall filename '/home/sep/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
# End of lines configured by zsh-newuser-install

# Custom below
export EDITOR=nvim

alias vim="nvim"
alias rm="trash"
alias c="clear"
alias ls='ls --color=auto'
alias grep='grep --color=auto'

figlet "Nah siesque rili" | lolcat

eval "$(starship init zsh)"
eval "$(zoxide init --cmd cd zsh)"
