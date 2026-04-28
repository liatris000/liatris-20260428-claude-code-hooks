#!/bin/bash
# Stop hook: タスク完了時にデスクトップ通知

INPUT=$(cat)
STOP_REASON=$(echo "${INPUT}" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('stop_reason',''))" 2>/dev/null)

MESSAGE="Claude Code タスク完了"
if [ "${STOP_REASON}" = "error" ]; then
  MESSAGE="⚠️ Claude Code: エラーで停止しました"
fi

# macOS
if command -v osascript &>/dev/null; then
  osascript -e "display notification \"${MESSAGE}\" with title \"Claude Code\" sound name \"Glass\""
fi

# Linux (notify-send)
if command -v notify-send &>/dev/null; then
  notify-send "Claude Code" "${MESSAGE}"
fi

# ターミナルベル（フォールバック）
echo -e "\a"

exit 0
