# Claude Code Hooks — 実務で使える6つのレシピ

Claude Code Hooks を使って開発ワークフローを自動化するための設定ファイルとスクリプト集です。

## 収録しているHook

| Hook | イベント | 説明 |
|------|---------|------|
| session-start.sh | SessionStart | セッション開始時にGit状態を表示 |
| pre-edit-check.sh | PreToolUse(Edit/Write) | 機密ファイルへの編集をブロック |
| pre-bash-guard.sh | PreToolUse(Bash) | 危険なコマンドをブロック |
| post-edit-format.sh | PostToolUse(Edit/Write) | 自動フォーマット（Prettier/Black/ruff） |
| post-bash-logger.sh | PostToolUse(Bash) | コマンドをログファイルに記録 |
| stop-notify.sh | Stop | タスク完了時にデスクトップ通知 |

## 使い方

1. リポジトリをクローン
2. `.claude/settings.json` をプロジェクトルートにコピー
3. `scripts/hooks/` ディレクトリをプロジェクトルートにコピー
4. 各スクリプトに実行権限を付与

```bash
chmod +x scripts/hooks/*.sh
```

5. Claude Codeを起動すると自動的にHookが動作します

## デモページ

`index.html` をブラウザで開くとHookの概要を確認できます。

## 記事

詳細な解説は [zenn.dev/liatris](https://zenn.dev/liatris) に掲載しています。
