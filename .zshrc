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

export PATH="$PATH:$HOME/.cargo/bin/:$HOME/.local/bin:$ANDROID_HOME/platform-tools:$HOME/.dotnet/tools:$HOME/go/bin"

export EDITOR="nvim"
export PAGER="less"
export MANPAGER="nvim +Man!"
export JAVA_HOME="/usr/lib/jvm/java-21-openjdk"
export LLDB_USE_NATIVE_PDB_READER="yes"
export ANDROID_HOME="/opt/android-sdk"
export ANDROID_NDK_HOME="/opt/android-sdk/ndk"
export NODE_COMPLILE_PATH=~/.cache/nodejs-compile-cache

source "$HOME/.zshvars.sh"

# Make ssh work
export TERM=xterm

alias tup="sudo tailscale up --accept-routes"
alias tdn="sudo tailscale down"

alias ls="ls --color"
# -F = show file type
# -C = columns format
# -l = long format
# -h = human readable
# -s = print file size
# -A = show hidden files
alias ll="ls --color -FCA"
#alias la="ls --color -FlAhs"
alias la="eza --color -lA"

alias grep="grep --color"
alias sudo="sudo-rs"
alias dig="dog"
alias bun="bun --bun"
alias bunx="bunx --bun"
alias cat="bat"
alias vim="nvim"
alias open="xdg-open"
alias rm="trash -v"
alias ps="ps auxf"
alias mkdir="mkdir -p"
alias rmm="/bin/rm -rf"
alias cp="cpg -g -i"
alias mv="mvg -g -i"
alias c="clear"
alias lg="lazygit"
alias fe="ferrite"
alias pw="packwiz"

alias notes="cd '$NOTES_DIR' && nvim '$NOTES_DIR'"

alias tls="tmux ls"
alias ta="tmux attach"
alias tn="tmux new -s"

alias 7x="7z x"
alias 7l="7z l"

alias gs="git status --short"
alias gd="git diff --output-indicator-new=' ' --output-indicator-old=' '"
alias ga="git add"
alias gc="git commit"
alias gp="git push"
alias gu="git pull"
alias gb="git branch"
alias gi="git init"
alias gy="git yolo"
alias gcl="git clone"
alias gap="git add --patch"
alias gl='git log --all --graph --pretty=format:"%C(magenta)%h %C(white) %an %ar%C(auto) %D%n%s%n"'
alias gn="git checkout -b"
alias gch="git checkout"
alias gst="git stash push -um"
alias gfm="git fetch && git merge"

gcm() { git commit --message "$*" }

[[ "$TERM_PROGRAM" == "vscode" ]] && unset ARGV0

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
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

function cdi-widget() {
  zle -I
  zle push-input
  BUFFER="cdi"
  zle accept-line
}

zle -N cdi-widget
bindkey '^F' cdi-widget

history-widget() {
  zle -I
  zle push-input
  BUFFER=$(fc -rl 1 | sed 's/^[[:space:]]*[0-9]\+[[:space:]]*//' | fzf --height=40%)
  if [[ -n $BUFFER ]]; then
    zle accept-line
  else
    zle redisplay
  fi
}

zle -N history-widget
bindkey '^H' history-widget

eval "$(thefuck --alias)"
eval "$(fzf --zsh)"
eval "$(starship init zsh)"
eval "$(zoxide init --cmd cd zsh)"
