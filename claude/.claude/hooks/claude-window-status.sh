#!/usr/bin/env bash
# Returns the dominant Claude status emoji for a tmux window.
# Uses pane_current_command as ground truth for whether Claude is alive,
# then reads per-pane state files for detailed state.
WINDOW_ID="$1"
[[ -n "$WINDOW_ID" ]] || exit 0

HAS_ATTENTION=0
HAS_THINKING=0
HAS_OPEN=0

while IFS=$'\t' read -r pane_id pane_cmd; do
  [[ "$pane_cmd" == "claude" ]] || continue
  state=$(cat "/tmp/claude_pane_${pane_id#%}" 2>/dev/null)
  case "$state" in
    attention) HAS_ATTENTION=1 ;;
    thinking)  HAS_THINKING=1 ;;
    *)         HAS_OPEN=1 ;;
  esac
done < <(tmux list-panes -t "$WINDOW_ID" -F '#{pane_id}	#{pane_current_command}' 2>/dev/null)

if   [[ $HAS_ATTENTION -eq 1 ]]; then printf '🔔'
elif [[ $HAS_THINKING  -eq 1 ]]; then printf '⚡'
elif [[ $HAS_OPEN      -eq 1 ]]; then printf '💬'
fi
