---
date: '2025-03-12T00:50:06+09:00'
draft: false
title: 'Docusaurusのランディングページを/docsにする'
tags: ['Docusaurus']
ShowToc: true
TocOpen: true
---

Docusaurusすごく気に入っているが、
ランディングページに表示したいものも無い・・・

ということで、デフォルトのランディングページではなく、`/docs`が開くようにする  

## 前提

classicテンプレートで構築

```bash
npx create-docusaurus@latest my-website classic
```

## ルートURLにアクセスしたときに`/docs`の内容を表示するように変更する

### `docusaurus.config.ts`に`routeBasePath: '/'`を設定する

```ts
presets: [
    [
      'classic',
      {
        docs: {
          routeBasePath: '/', // <- これを追加する
          sidebarPath: './sidebars.ts',
          // ...
        },
        blog: {
          // ...
        }
        // ...
      }
    ]
]
```

### `src/pages/index.tsx`を削除する

- `/`が競合するため（警告ログが出る）
- 削除したくない場合は、リネームする

### front matterに`slug: /`を追加する

- 例として`docs/intro.md`に設定する

```md
---
sidebar_position: 1
slug: /
---
```

## おわりに

実は他にも方法がいくつかあるが、個人的にこの方法が一番分かりやすかった。

ドキュメントサイトだったらDocusaurusが今一番オススメ。ブログ機能はリリースノートとして使うのが良さそう（本家はそういう使い方をしているようだ）
