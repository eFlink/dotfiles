eval "$(starship init zsh)"

export PATH="$PATH:$(go env GOPATH)/bin"

cdf() {
  local dir
  dir=$(find . -type d 2>/dev/null | fzf --prompt="cd > ") && cd "$dir"
}

# Expand "..." -> "../.." , "...." -> "../../.." as you type
rationalise-dot() {
  if [[ $LBUFFER = *.. ]]; then
    LBUFFER+=/..
  else
    LBUFFER+=.
  fi
}
zle -N rationalise-dot
bindkey . rationalise-dot
# Keep "." literal when typing/pasting at the start or inside quotes
bindkey -M isearch . self-insert

# git worktree aliases
alias gwt='git worktree'
alias gwta='git worktree add'
alias gwtl='git worktree list'
alias gwtp='git worktree prune'

# remove one or more worktrees; supports globs like: gwtr CF-*
gwtr() {
  for wt in "$@"; do
    git worktree remove "$wt"
  done
}

# Lazygit & Lazydocker
alias lg='lazygit'
alias ld='lazydocker'

alias .='nvim'

# ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
