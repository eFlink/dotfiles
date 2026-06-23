#!/usr/bin/env bash
[[ -n "$TMUX" ]] || exit 0

PAYLOAD=$(cat)
EVENT=$(printf '%s' "$PAYLOAD" | /usr/bin/grep -o '"hook_event_name":"[^"]*"' | cut -d'"' -f4)
[[ -n "$TMUX_PANE" ]] || exit 0

PANE_ID="${TMUX_PANE#%}"
STATE_FILE="/tmp/claude_pane_${PANE_ID}"

case "$EVENT" in
  UserPromptSubmit|PreToolUse|PostToolUse) echo "thinking"  > "$STATE_FILE" ;;
  Notification|PermissionRequest)          echo "attention" > "$STATE_FILE" ;;
  SessionStart|Stop)                       echo "open"      > "$STATE_FILE" ;;
  SessionEnd)
    rm -f "$STATE_FILE"
    tmux refresh-client -S 2>/dev/null
    exit 0
    ;;
  *) exit 0 ;;
esac

tmux refresh-client -S
