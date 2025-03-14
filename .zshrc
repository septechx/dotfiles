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

zinit snippet OMZP::asdf
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

export PATH="$PATH:$HOME/.cargo/bin/:$HOME/.millennium/ext/bin:${HOME}/.local/bin"

export EDITOR="nvim"
export MANPAGER="nvim +Man!"
export JAVA_HOME="/usr/lib/jvm/java-21-openjdk"
export LLDB_USE_NATIVE_PDB_READER="yes"
export ANDROID_HOME="/opt/android-sdk"
export ANDROID_NDK_HOME="/opt/android-sdk/ndk"

alias ls="ls --color"
alias grep="grep --color"
alias bun="bun --bun"
alias bunx="bunx --bun"
alias cat="bat"
alias htop="btop"
alias vim="nvim"
alias open="xdg-open"
alias rm="trash"
alias c="clear"
alias lg="lazygit"
alias tls="tmux ls"
alias ta="tmux attach"
alias tn="tmux new -s"
alias gp="git push"

read -r ferium_github_key < "$HOME/dotfiles/secrets.txt"
alias ferium="ferium --github-token $ferium_github_key"

source /usr/share/nvm/init-nvm.sh

export PNPM_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/pnpm"
case ":$PATH:" in
    *":$PNPM_HOME:"*) ;;
    *) export PATH="$PNPM_HOME:$PATH" ;;
esac

export ZVM_INSTALL="$HOME/.zvm/self"
export PATH="$PATH:$HOME/.zvm/bin"
export PATH="$PATH:$ZVM_INSTALL/"

# proto
export PROTO_HOME="$HOME/.proto";
export PATH="$PROTO_HOME/shims:$PROTO_HOME/bin:$PATH";

# bun completions
[ -s "/home/sep/.bun/_bun" ] && source "/home/sep/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

eval $(thefuck --alias)
eval "$(fzf --zsh)"
eval "$(starship init zsh)"
eval "$(zoxide init --cmd cd zsh)"


