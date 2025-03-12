---
date: '2025-02-16T15:00:00+09:00'
draft: false
title: 'Hugo PaperModでMermaid記法を表示できるようにする'
tags: ['hugo']
ShowToc: true
TocOpen: true
---

## 執筆時(2025/02/16)にはMermaidが表示できない

Mermaidがレンダリングされるようにしてみる。

### hugo-PaperModのDiscussions

[Mermaid doesn't work #850](https://github.com/adityatelange/hugo-PaperMod/discussions/850)

### 方法

下記2ファイルを作成する

`layouts/_default/_markup/render-codeblock-mermaid.html`

```html
<pre class="mermaid">
    {{- .Inner | htmlEscape | safeHTML }}
</pre>
{{ .Page.Store.Set "hasMermaid" true }}
```

`layouts/partials/extend_head.html`

```html
{{ if .Store.Get "hasMermaid" }}
<script src="https://cdn.jsdelivr.net/npm/mermaid@11/dist/mermaid.min.js" integrity="sha256-pDvBr9RG+cTMZqxd1F0C6NZeJvxTROwO94f4jW3bb54=" crossorigin="anonymous"></script>
<script>
  mermaid.initialize({ 
    startOnLoad: true,
  });
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
