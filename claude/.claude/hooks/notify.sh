#!/usr/bin/env bash
# Claude Code notification hook for tmux + macOS.
[[ "$(uname)" == "Darwin" ]] || exit 0
PAYLOAD=$(cat)
EVENT=$(printf '%s' "$PAYLOAD" | /usr/bin/grep -o '"hook_event_name":"[^"]*"' | cut -d'"' -f4)
CWD=$(printf '%s' "$PAYLOAD" | /usr/bin/grep -o '"cwd":"[^"]*"' | cut -d'"' -f4)
case "$EVENT" in
Stop) MSG="Done" ;;
*) MSG="${EVENT:-Update}" ;;
esac
# tmux context
WINDOW_IDX=""
if [[ -n "$TMUX" && -n "$TMUX_PANE" ]]; then
  WINDOW_IDX=$(tmux display-message -t "$TMUX_PANE" -p '#{window_index}' 2>/dev/null)
fi
LOCATION="Claude Code"
# Project + branch from the pane's cwd (falls back gracefully)
PROJECT=""
BRANCH=""
if [[ -n "$CWD" && -d "$CWD" ]]; then
  PROJECT=$(basename "$CWD")
  BRANCH=$(git -C "$CWD" symbolic-ref --short HEAD 2>/dev/null ||
    git -C "$CWD" rev-parse --short HEAD 2>/dev/null)
fi
# Build body: "7: branch - Done" or "7: branch_project - Done" if they differ
LABEL=""
if [[ -n "$BRANCH" && -n "$PROJECT" && "$BRANCH" != "$PROJECT" ]]; then
  LABEL="${BRANCH}_${PROJECT}"
elif [[ -n "$BRANCH" ]]; then
  LABEL="${BRANCH}"
elif [[ -n "$PROJECT" ]]; then
  LABEL="${PROJECT}"
fi
BODY="$MSG"
if [[ -n "$LABEL" ]]; then
  if [[ -n "$WINDOW_IDX" ]]; then
    BODY="${WINDOW_IDX}: ${LABEL} - ${MSG}"
  else
    BODY="${LABEL}: ${MSG}"
  fi
elif [[ -n "$WINDOW_IDX" ]]; then
  BODY="${WINDOW_IDX}: ${MSG}"
fi
if command -v terminal-notifier >/dev/null 2>&1; then
  terminal-notifier \
    -title "Claude Code" \
    -message "$BODY" \
    -sound default
else
  osascript -e "display notification \"$BODY\" with title \"Claude Code\" subtitle \"$LOCATION\" sound name \"Glass\""
fi
