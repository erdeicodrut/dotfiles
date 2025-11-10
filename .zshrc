##### ⚡️ Ultra-fast prompt preloading (Powerlevel10k) — keep at very top
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

##### 🧱 Oh My Zsh core
export ZSH="$HOME/.oh-my-zsh"
ZSH_CUSTOM="${ZSH_CUSTOM:-$ZSH/custom}"

##### 🛣️ PATH + env
# Add things safely; then de-duplicate with 'typeset -U path'
path=(
  "$HOME/fvm/default/bin"
  "$HOME/.cargo/bin"
  "$HOME/go/bin"
  "$HOME/.local/bin"
  "/opt/homebrew/anaconda3/bin"
  "$HOME/Android/Sdk/cmdline-tools/latest/bin"
  "$HOME/Android/Sdk/platform-tools"
  "$HOME/Android/Sdk/tools/bin"
  $path
)
typeset -U path PATH


ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

# Rust env (uncomment if you want automatic toolchain env)
# [[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"


plugins=(
  git
  sudo
  # Conditional ones (added only if installed):
  zsh-256color
  zsh-autosuggestions
  fzf-tab
  fast-syntax-highlighting  # or zsh-syntax-highlighting if fast isn’t installed
)

source "$ZSH/oh-my-zsh.sh"

##### ✏️ Editor preference
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi
alias v='nvim'

##### 🧰 Handy aliases (prefer modern tools if present)
if command -v eza >/dev/null 2>&1; then
  alias ls='eza'
  alias ll='eza -alF --icons'
  alias la='eza -a'
  alias l='eza -F'
else
  # Fallbacks
  if command -v dircolors >/dev/null 2>&1; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
  fi
  alias ll='ls -alF'
  alias la='ls -A'
  alias l='ls -CF'
fi

alias fg="flutter pub run build_runner build --delete-conflicting-outputs"

##### 🔎 fzf integration (guarded so it won’t error if not installed)
if command -v fzf >/dev/null 2>&1; then
  eval "$(fzf --zsh)"

  export FZF_DEFAULT_COMMAND='fd --hidden --strip-cwd-prefix --exclude .git'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND='fd --type d --hidden --strip-cwd-prefix --exclude .git'

  _fzf_compgen_path() { fd --hidden --exclude .git . "$1"; }
  _fzf_compgen_dir()  { fd --type d --hidden --exclude .git . "$1"; }

  show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

  export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
  export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

  _fzf_comprun() {
    local command=$1; shift
    case "$command" in
      cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
      export|unset) fzf --preview "eval 'echo ${}'" "$@" ;;
      ssh)          fzf --preview 'dig {}' "$@" ;;
      *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
    esac
  }
fi

##### 🧭 zoxide (optional)
command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init zsh)" && alias cd='z'

##### 🌟 Prompt (Starship) — don’t combine with Powerlevel10k theme
if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

##### 🕘 History tweaks
HISTFILE="$HOME/.zhistory"
SAVEHIST=100000
HISTSIZE=100000
setopt share_history hist_expire_dups_first hist_ignore_dups hist_verify

##### ↑↓ history search with arrows
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

##### 🎨 Syntax highlighting fallback via Homebrew (ONLY if plugin not loaded)
if ! typeset -p plugins 2>/dev/null | grep -q 'fast-syntax-highlighting\|zsh-syntax-highlighting'; then
  [[ -r /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] \
    && source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

##### 🖼️ System info on shell start (silent if missing)
command -v neofetch >/dev/null 2>&1 && neofetch

##### 🧠 Jina CLI completion (guarded)
if [[ -o interactive ]] && command -v jina >/dev/null 2>&1; then
  compctl -K _jina jina
  _jina() {
    local words completions
    read -cA words
    if [ "${#words}" -eq 2 ]; then
      completions="$(jina commands)"
    else
      completions="$(jina completions ${words[2,-2]})"
    fi
    reply=(${(ps:
:)completions})
  }
fi

##### ☕ SDKMAN — must be last
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"

alias sse="ssh servere@192.168.3.225"

# Flutter
alias fbr='flutter pub run build_runner build --delete-conflicting-outputs'
alias fbrw='flutter pub run build_runner watch --delete-conflicting-outputs'


if [[ "$TERM_PROGRAM" == "ghostty" ]]; then
    export TERM=xterm-256color
fi
