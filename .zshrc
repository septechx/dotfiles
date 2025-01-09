ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

zinit snippet OMZP::sudo
zinit snippet OMZP::command-not-found

autoload -U compinit && compinit

zinit cdreplay -q

bindkey "^y" autosuggest-accept
bindkey "^p" history-search-backward
bindkey "^n" history-search-forward

HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

zstyle ":completion:*" matcher-list "m:{a-z}={A-Za-z}"
zstyle ":completion:*" list-colors "${(s.:.)LS_COLORS}"
zstyle ":completion:*" menu no
zstyle ":fzf-tab:complete:cd:*" fzf-preview "ls --color $realpath"
zstyle ":fzf-tab:complete:__zoxide_z:*" fzf-preview "ls --color $realpath"

export PATH="$PATH:$HOME/repos/zigdown/zig-out/bin/:${XDG_DATA_HOME:-${HOME}/.local/share}/zigdown:$HOME/bin/platform-tools/:$HOME/.cargo/bin/:$HOME/.millennium/ext/bin:${HOME}/.local/bin"

export EDITOR="nvim"
export MANPAGER="nvim +Man!"

alias ls="ls --color"
alias grep="grep --color"
alias cat="bat"
alias htop="btop"
alias vim="nvim"
alias rm="trash"
alias c="clear"
alias lg="lazygit"
alias tml="tmux ls"
alias tma="tmux attach"
alias tmk="tmux kill-server"
alias tm="~/dotfiles/scripts/tmux.sh"

read -r ferium_github_key < "$HOME/dotfiles/secrets.txt"
alias ferium="ferium --github-token $ferium_github_key"

source /usr/share/nvm/init-nvm.sh

export PNPM_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/pnpm"
case ":$PATH:" in
    *":$PNPM_HOME:"*) ;;
    *) export PATH="$PNPM_HOME:$PATH" ;;
esac

eval "$(fzf --zsh)"
eval "$(starship init zsh)"
eval "$(zoxide init --cmd cd zsh)"
