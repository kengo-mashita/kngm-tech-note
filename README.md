# kngm-blog

Static Site Generator:[Hugo](https://gohugo.io/)

Hugo Theme:[Hugo PaperMod](https://github.com/adityatelange/hugo-PaperMod)

Hosting Service:[GitHub Pages](https://docs.github.com/ja/pages)

## create new content

```
hugo new content posts/2023/09/17/index.md
```

## hugo server

`http://localhost:1313/`
```
hugo server
```

### include content marked as draft

```
hugo server -D
```

### include content with publishdate in the future

```
hugo server -F
```

### useful

```
hugo server -D -F
```