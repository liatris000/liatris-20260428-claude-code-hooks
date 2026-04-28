#!/bin/bash
# PreToolUse(Bash) hook: 危険なコマンドをブロック

INPUT=$(cat)
COMMAND=$(echo "${INPUT}" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('tool_input',{}).get('command',''))" 2>/dev/null)

# 危険なコマンドパターン
DANGEROUS_PATTERNS=(
  "rm -rf /"
  "rm -rf ~"
  "rm -rf \$HOME"
  "> /dev/sda"
  "dd if=/dev/zero"
  "mkfs\."
  "chmod -R 777 /"
  ":(){ :|:& };:"
)

for pattern in "${DANGEROUS_PATTERNS[@]}"; do
  if echo "${COMMAND}" | grep -qE "${pattern}"; then
    echo "{\"decision\": \"block\", \"reason\": \"⛔ 危険なコマンドを検出しました: ${pattern}\"}"
    exit 0
  fi
done

# 本番環境への直接デプロイは警告
if echo "${COMMAND}" | grep -qE "(deploy|push).*(prod|production|main)"; then
  echo "{\"decision\": \"confirm\", \"message\": \"🚨 本番環境へのデプロイが含まれます。続行しますか？\"}" >&2
fi

exit 0
