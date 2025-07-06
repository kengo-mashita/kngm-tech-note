---
date: '2025-07-06T16:48:08+09:00'
draft: false
title: 'GitHub CLI を使った不要リポジトリの一括削除手順'
tags: ['GitHub', 'GitHubCLI']
ShowToc: true
TocOpen: true
---

## はじめに

GitHubを長く使っていると、学習用やテスト用のリポジトリが溜まってくる。ブラウザで一つずつ削除するのは時間がかかるが、GitHub CLIを使えば効率的に整理できる。

この記事では、GitHub CLIを使って不要なリポジトリを安全かつ効率的に削除する方法を解説する。

## 事前準備

### GitHub CLI のインストール

GitHub CLI（gh）をインストールする。

[GitHub CLI公式サイト](https://cli.github.com/)

### 認証設定

```zsh
gh auth login
```

対話形式で認証情報を設定する。ブラウザまたはトークンでの認証が選択できる。

**重要：** リポジトリ削除には特別な権限が必要である

```zsh
gh auth refresh -h github.com -s delete_repo
```

## 削除対象リポジトリの確認

### 全リポジトリの一覧表示

```zsh
# 自分の全リポジトリを表示
gh repo list --limit 10

# 詳細情報付きで表示
gh repo list --limit 10 --json name,updatedAt,description
```

### 削除対象の決定

以下の基準で削除対象を決める

- **学習用コード** - チュートリアルの写しなど
- **テスト用リポジトリ** - 動作確認のみの目的
- **古いコード** - 技術スタックが古く参照価値がない
- **重複コンテンツ** - 同じような内容のリポジトリ

## 削除の実行

### 単体削除

```bash
# 確認ありの削除
gh repo delete username/repository-name

# 確認なしの削除（注意）
gh repo delete username/repository-name --yes
```

### 一括削除スクリプト

削除対象が多い場合は、スクリプトを作成する。

#### delete_repos.sh

```zsh
#!/bin/bash

# 削除対象リポジトリのリスト
repos=(
    "username/old-tutorial-1"
    "username/practice-code-2"
    "username/test-project-3"
)

echo "The following repositories will be deleted:"
for repo in "${repos[@]}"; do
    echo "- $repo"
done

read -p "Do you want to continue? (y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    for repo in "${repos[@]}"; do
        echo "Deleting: $repo"
        gh repo delete "$repo" --yes
        if [ $? -eq 0 ]; then
            echo "✓ Successfully deleted $repo"
        else
            echo "✗ Failed to delete $repo"
        fi
        sleep 1  # API制限を避けるため少し待機
    done
    echo "Deletion process completed"
else
    echo "Deletion cancelled"
fi
```

**スクリプトの実行：**

```bash
chmod +x delete_repos.sh
./delete_repos.sh
```

## 安全な削除のベストプラクティス

### 1. 段階的削除

```bash
# まず1つだけ削除してテスト
gh repo delete username/test-repo --yes

# 問題なければ少数ずつ削除
# 一度に大量削除は避ける
```

### 2. 重要なコードのバックアップ

```bash
# 削除前にローカルにクローン
git clone https://github.com/username/important-repo.git
cd important-repo
git bundle create backup.bundle --all
```

### 3. 削除前の最終確認

```bash
# リポジトリの詳細確認
gh repo view username/repository-name

# 最近のコミット確認
gh repo view username/repository-name --web
```

### 4. フォーク状況の確認

```bash
# フォークされているかチェック
gh api repos/username/repository-name --jq '.forks_count'
```

## 削除できない場合のトラブルシューティング

### 権限エラー

```bash
# 認証状態の確認
gh auth status

# delete_repo権限の追加
gh auth refresh -h github.com -s delete_repo

# 再認証
gh auth login --force
```

### API制限エラー

大量削除時にAPI制限にかかる場合

```bash
# スクリプトにsleepを追加
sleep 2  # 2秒待機
```

### 依存関係のあるリポジトリ

- GitHub Pagesが有効な場合は先に無効化
- GitHub Actionsが動作中の場合は停止
- Webhookが設定されている場合は削除

## まとめ

GitHub CLIを使うことで、ブラウザでの手動削除と比べて大幅に効率化できる。

**メリット：**

- コマンド一発で削除完了
- スクリプト化で一括処理可能
- 削除前の確認機能
- エラーハンドリングが容易

**注意点：**

- 削除は元に戻せない
- 重要なコードは事前にバックアップ
- 段階的に削除して安全性を確保

定期的なリポジトリ整理で、GitHubアカウントをスッキリ保とう。
GitHub CLIは他の操作も効率化できるので、この機会に活用してみると良い。
