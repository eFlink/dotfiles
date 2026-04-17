eval "$(starship init zsh)"

cdf() {
  local dir
  dir=$(find . -type d 2>/dev/null | fzf --prompt="cd > ") && cd "$dir"
}
