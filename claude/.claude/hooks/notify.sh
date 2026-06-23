#!/usr/bin/env bash
# Claude Code notification hook for tmux + macOS.
[[ "$(uname)" == "Darwin" ]] || exit 0

PAYLOAD=$(cat)
EVENT=$(printf '%s' "$PAYLOAD" | /usr/bin/grep -o '"hook_event_name":"[^"]*"' | cut -d'"' -f4)
CWD=$(printf '%s' "$PAYLOAD" | /usr/bin/grep -o '"cwd":"[^"]*"' | cut -d'"' -f4)
NOTIF_MSG=$(printf '%s' "$PAYLOAD" | /usr/bin/grep -o '"message":"[^"]*"' | cut -d'"' -f4)

case "$EVENT" in
Stop) MSG="Done" ;;
Notification) MSG="${NOTIF_MSG:-Waiting for input}" ;;
*) MSG="${EVENT:-Update}" ;;
esac

# tmux context
WINDOW_IDX=""
if [[ -n "$TMUX" && -n "$TMUX_PANE" ]]; then
  WINDOW_IDX=$(tmux display-message -t "$TMUX_PANE" -p '#{window_index}' 2>/dev/null)
fi

TITLE="Claude Code"

# Project + branch from the pane's cwd (falls back gracefully)
PROJECT=""
BRANCH=""
if [[ -n "$CWD" && -d "$CWD" ]]; then
  PROJECT=$(basename "$CWD")
  BRANCH=$(git -C "$CWD" symbolic-ref --short HEAD 2>/dev/null ||
    git -C "$CWD" rev-parse --short HEAD 2>/dev/null)
fi

# Build label: "branch" or "branch_project" if branch and project differ
LABEL=""
if [[ -n "$BRANCH" && -n "$PROJECT" && "$BRANCH" != "$PROJECT" ]]; then
  LABEL="${BRANCH}_${PROJECT}"
elif [[ -n "$BRANCH" ]]; then
  LABEL="${BRANCH}"
elif [[ -n "$PROJECT" ]]; then
  LABEL="${PROJECT}"
fi

SUBTITLE="Claude Code"
if [[ -n "$LABEL" ]]; then
  if [[ -n "$WINDOW_IDX" ]]; then
    SUBTITLE="${WINDOW_IDX}: ${LABEL}"
  else
    SUBTITLE="${LABEL}"
  fi
elif [[ -n "$WINDOW_IDX" ]]; then
  SUBTITLE="${WINDOW_IDX}"
fi

if command -v terminal-notifier >/dev/null 2>&1; then
  launchctl asuser "$(id -u)" terminal-notifier \
    -title "$TITLE" \
    -subtitle "$SUBTITLE" \
    -message "$MSG" \
    -sound default
else
  osascript -e "display notification \"$MSG\" with subtitle \"$SUBTITLE\" sound name \"Glass\""
fi
