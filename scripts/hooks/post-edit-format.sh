#!/bin/bash
# PostToolUse(Edit/Write) hook: 編集後に自動フォーマット

INPUT=$(cat)

FILE_PATH=$(echo "${INPUT}" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('tool_input',{}).get('file_path',''))" 2>/dev/null)

if [ -z "${FILE_PATH}" ] || [ ! -f "${FILE_PATH}" ]; then
  exit 0
fi

EXT="${FILE_PATH##*.}"

case "${EXT}" in
  js|jsx|ts|tsx|json|css|md)
    if command -v prettier &>/dev/null; then
      prettier --write "${FILE_PATH}" --loglevel warn
      echo "✅ Prettierフォーマット完了: ${FILE_PATH}" >&2
    fi
    ;;
  py)
    if command -v black &>/dev/null; then
      black "${FILE_PATH}" -q
      echo "✅ Blackフォーマット完了: ${FILE_PATH}" >&2
    elif command -v ruff &>/dev/null; then
      ruff format "${FILE_PATH}"
      echo "✅ Ruffフォーマット完了: ${FILE_PATH}" >&2
    fi
    ;;
  sh)
    if command -v shfmt &>/dev/null; then
      shfmt -w "${FILE_PATH}"
      echo "✅ shfmtフォーマット完了: ${FILE_PATH}" >&2
    fi
    ;;
esac

exit 0
