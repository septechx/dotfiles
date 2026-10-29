# Uncomment to profile
# zmodload zsh/zprof

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

# Vi mode (vim-like navigation)
bindkey -v
export KEYTIMEOUT=1

# jk / kj to escape to normal mode
bindkey -M viins 'jk' vi-cmd-mode
bindkey -M viins 'kj' vi-cmd-mode

# Keep existing custom bindings available in vi insert mode
bindkey -M viins "^y" autosuggest-accept
bindkey -M viins "^p" history-search-backward
bindkey -M viins "^n" history-search-forward

# h/j/k/l navigation in completion menu
zmodload -i zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# Editable command line in $EDITOR with v in normal mode
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd 'v' edit-command-line

# Change cursor shape for different vi modes
function zle-keymap-select {
  case $KEYMAP in
    vicmd) echo -ne '\e[1 q' ;;      # block
    viins|main) echo -ne '\e[5 q' ;; # beam
  esac
}
zle -N zle-keymap-select
function zle-line-init {
  echo -ne '\e[5 q' # beam on new prompt
}
zle -N zle-line-init

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

alias tup="tailscale up --accept-routes"
alias tdn="tailscale down"

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
alias sudo="sudo "
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
alias c="clear -x"
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

export PNPM_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/pnpm"
case ":$PATH:" in
    *":$PNPM_HOME:"*) ;;
    *) export PATH="$PNPM_HOME:$PATH" ;;
esac

export ZVM_INSTALL="$HOME/.zvm/self"
export PATH="$PATH:$HOME/.zvm/bin"
export PATH="$PATH:$ZVM_INSTALL/"

export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

# proto
export PROTO_HOME="$HOME/.proto";
export PATH="$PROTO_HOME/shims:$PROTO_HOME/bin:$PATH";

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# fnm
FNM_PATH="$HOME/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
  eval "`fnm env`"
fi

function cdi-widget() {
  zle -I
  zle push-input
  BUFFER="cdi"
  zle accept-line
}

zle -N cdi-widget
bindkey -M viins '^F' cdi-widget
bindkey -M vicmd '^F' cdi-widget

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
bindkey -M viins '^H' history-widget
bindkey -M vicmd '^H' history-widget

eval "$(thefuck --alias)"
eval "$(fzf --zsh)"
eval "$(starship init zsh)"
eval "$(zoxide init --cmd cd zsh)"

# Uncomment to profile
# zprof

# terminal-wakatime setup
export PATH="$HOME/.wakatime:$PATH"
eval "$(terminal-wakatime init)"
