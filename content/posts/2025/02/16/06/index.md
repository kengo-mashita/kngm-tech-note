---
date: '2025-02-16T15:00:00+09:00'
draft: false
title: 'Hugo PaperModでMermaid記法を表示できるようにする'
tags: ['hugo']
ShowToc: true
TocOpen: true
---

## [2025/06/21更新]現在HugoにはMermaidを表示できる組み込みテンプレートが用意されていない

独自テンプレートを作成して、Mermaidがレンダリングされるようにしてみる。

### 方法

下記ファイルを作成する

`layouts/_markup/render-codeblock-mermaid.html`

```html
<pre class="mermaid">
  {{ .Inner | htmlEscape | safeHTML }}
</pre>
{{ .Page.Store.Set "hasMermaid" true }}
```

`themes/PaperMod/layouts/_default/baseof.html`の`</body>`の前に追加する

```html
{{ if .Store.Get "hasMermaid" }}
  <script type="module">
    import mermaid from 'https://cdn.jsdelivr.net/npm/mermaid/dist/mermaid.esm.min.mjs';
    mermaid.initialize({ startOnLoad: true });
  </script>
{{ end }}
```

### 結果

```mermaid
graph TD;
    A-->B;
    A-->C;
    B-->D;
    C-->D;
```

これでMermaidがレンダリングされる:tada:
