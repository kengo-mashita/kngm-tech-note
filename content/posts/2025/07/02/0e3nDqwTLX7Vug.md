---
date: '2025-07-02T23:49:52+09:00'
draft: false
title: 'nodebrewで管理されたNode.js環境でClaude Desktop用のGitHub MCPサーバーを設定する'
tags: ['Claude']
ShowToc: true
TocOpen: true
---

## 前提条件

- nodebrewがインストールされている
- Node.jsがnodebrewでインストールされている
- GitHub Personal Access Tokenが発行済みである

## 設定手順

### 1. MCPサーバー起動スクリプトの作成

ホームディレクトリに`mcp-github.sh`スクリプトを作成する

```zsh
#!/bin/bash
export PATH="$HOME/.nodebrew/current/bin:$PATH"
export GITHUB_PERSONAL_ACCESS_TOKEN="your_actual_token_here"
exec npx -y @modelcontextprotocol/server-github
```

**重要**: `your_actual_token_here`を実際のGitHub Personal Access Tokenに置き換える

### 2. スクリプトに実行権限を付与

```zsh
chmod +x ~/mcp-github.sh
```

### 3. Claude Desktop設定ファイルの編集

Claude Desktopの設定ファイル（`~/Library/Application Support/Claude/claude_desktop_config.json`）を編集し、以下の内容を追加する

```json
{
  "mcpServers": {
    "github": {
      "command": "/Users/USERNAME/mcp-github.sh",
      "args": []
    }
  }
}
```

**注意**: `USERNAME`を実際のユーザー名に置き換える

## 設定の確認

1. Claude Desktopを再起動する
2. GitHub関連のコマンドが利用可能になっていることを確認する

## トラブルシューティング

- スクリプトが実行されない場合は、パスが正しいか確認する
- GitHub APIの認証エラーが発生する場合は、Personal Access Tokenの権限設定を確認する
- Node.jsが見つからない場合は、nodebrewの設定とPATHを確認する
