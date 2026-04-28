#!/bin/bash
# SessionStart hook: プロジェクト開始時に状態サマリーを表示

echo "╔══════════════════════════════════════╗"
echo "║   Claude Code セッション開始         ║"
echo "╚══════════════════════════════════════╝"
echo ""

# Gitブランチと状態
BRANCH=$(git branch --show-current 2>/dev/null || echo "N/A")
echo "📁 ブランチ: ${BRANCH}"

# 未コミットファイル数
UNCOMMITTED=$(git status --porcelain 2>/dev/null | wc -l | tr -d ' ')
if [ "${UNCOMMITTED}" -gt 0 ]; then
  echo "⚠️  未コミット変更: ${UNCOMMITTED}件"
else
  echo "✅ 未コミット変更: なし"
fi

# 直近のコミット
LAST_COMMIT=$(git log --oneline -1 2>/dev/null || echo "コミットなし")
echo "📝 最新コミット: ${LAST_COMMIT}"

# .envファイルの存在確認
if [ -f ".env" ]; then
  echo "🔑 .envファイル: あり（機密情報に注意）"
fi

echo ""
echo "セッション開始: $(date '+%Y-%m-%d %H:%M:%S')"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
