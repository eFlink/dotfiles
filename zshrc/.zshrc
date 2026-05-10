eval "$(starship init zsh)"

cdf() {
  local dir
  dir=$(find . -type d 2>/dev/null | fzf --prompt="cd > ") && cd "$dir"
}

# git worktree aliases
alias gwt='git worktree'
alias gwta='git worktree add'
alias gwtl='git worktree list'
alias gwtr='git worktree remove'
alias gwtp='git worktree prune'
