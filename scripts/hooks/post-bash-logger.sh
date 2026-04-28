#!/bin/bash
# PostToolUse(Bash) hook: 実行コマンドをログに記録

INPUT=$(cat)
LOG_FILE="${HOME}/.claude/bash-history.log"
mkdir -p "$(dirname "${LOG_FILE}")"

COMMAND=$(echo "${INPUT}" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('tool_input',{}).get('command','')[:200])" 2>/dev/null)
EXIT_CODE=$(echo "${INPUT}" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('tool_response',{}).get('exit_code','?'))" 2>/dev/null)

if [ -n "${COMMAND}" ]; then
  TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
  echo "${TIMESTAMP} [exit:${EXIT_CODE}] ${COMMAND}" >> "${LOG_FILE}"
fi

exit 0
