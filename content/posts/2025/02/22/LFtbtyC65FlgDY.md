---
date: '2025-02-22T01:00:07+09:00'
draft: true
title: '2025-02-22T01:00:07+09:00'
tags: ['React', 'VSCode']
ShowToc: true
TocOpen: true
---

# ローカル環境でReactがとりあえず動く環境を作る(2025年2月版)

## 動機
Reactの学習用に、とりあえずVSCodeで書ける環境を作りたい。

ESLintとPrettierは有効にしたい。

## 方法

[vite](https://ja.vite.dev/)を使用する。

※`Node.js`がローカル環境にインストール済みであること

### プロジェクト作成

下記コマンドを実行する

```bash
pnpm create vite
```

### 不要ファイルの削除、編集

デフォルトだと、ロゴなどが表示されるので、Hello Worldだけ表示するようにする。

ロゴファイルやCSSを削除

```
rm src/assets/react.svg
rm public/vite.svg
rm src/App.css
```

`App.tsx`の編集

```js
export default function App() {
  return <h1>hello world</h1>;
}
```

`index.css`の編集

```js
body {
  margin: 0;
  font-family: system-ui, sans-serif;
}
```

`main.tsx`の編集

```js
import { StrictMode } from 'react';
import { createRoot } from 'react-dom/client';
import App from './App';
import './index.css';

createRoot(document.getElementById('root')!).render(
  <StrictMode>
    <App />
  </StrictMode>
);
```

`index.html`の編集

```html
<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Hello World</title>
  </head>
  <body>
    <div id="root"></div>
    <script type="module" src="/src/main.tsx"></script>
  </body>
</html>
```

### VSCodeの設定

GitHub Copilotにベースを作成してもらい、最終的な設定は下記にした。

`.vscode/settings.json`

```json
{
    "editor.bracketPairColorization.enabled": true,
    "editor.codeActionsOnSave": {
        "source.fixAll.eslint": "explicit"
    },
    "editor.defaultFormatter": "esbenp.prettier-vscode",
    "editor.formatOnSave": true,
    "editor.tabSize": 2,
    "eslint.validate": [
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact"
    ],
    "files.associations": {
        "*.ts": "typescript",
        "*.tsx": "typescriptreact"
    },
    "files.autoSave": "onFocusChange",
    "files.eol": "\n",
    "files.insertFinalNewline": true,
    "files.trimTrailingWhitespace": true,
    "javascript.validate.enable": false,
    "prettier.requireConfig": true,
    "typescript.tsdk": "node_modules/typescript/lib",
    "typescript.updateImportsOnFileMove.enabled": "always",
    "typescript.validate.enable": true
}
```

`.vscode/extensions.json`

```json
{
  "recommendations": [
    "dbaeumer.vscode-eslint",
    "esbenp.prettier-vscode",
    "ms-vscode.vscode-typescript-next",
    "dsznajder.es7-react-js-snippets",
    "ms-vscode.js-debug"
  ]
}
```

### 起動

```bash
pnpm dev
```

`http://localhost:5173/`

## Bonus

Tailwind CSSを追加する方法

[Get started with Tailwind CSS
](https://tailwindcss.com/docs/installation/using-vite)
