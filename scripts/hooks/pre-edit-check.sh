#!/bin/bash
# PreToolUse(Edit) hook: 編集前にガードレールチェック
# 標準入力からJSONを受け取る

INPUT=$(cat)

# 編集対象ファイルパスを取得
FILE_PATH=$(echo "${INPUT}" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('tool_input',{}).get('file_path',''))" 2>/dev/null)

if [ -z "${FILE_PATH}" ]; then
  exit 0
fi

# 保護ファイルリスト
PROTECTED_FILES=(
  ".env"
  ".env.production"
  ".env.local"
  "secrets.json"
  "credentials.json"
  "private_key.pem"
)

for protected in "${PROTECTED_FILES[@]}"; do
  if [[ "${FILE_PATH}" == *"${protected}" ]]; then
    echo "{\"decision\": \"block\", \"reason\": \"⛔ 保護ファイル '${protected}' への編集は禁止されています。\"}"
    exit 0
  fi
done

# package.json の直接書き換えは警告
if [[ "${FILE_PATH}" == *"package.json" ]]; then
  echo "{\"decision\": \"warn\", \"message\": \"⚠️ package.json を編集します。依存関係の変更に注意してください。\"}" >&2
fi

exit 0
