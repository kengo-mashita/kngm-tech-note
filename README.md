# kngm-tech-note

Static Site Generator:[Hugo](https://gohugo.io/)

Hugo Theme:[Hugo PaperMod](https://github.com/adityatelange/hugo-PaperMod)

Hosting Service:[GitHub Pages](https://docs.github.com/ja/pages)

## create new content

zsh

```zsh
zsh create_post.sh
```

or

```zsh
hugo new content posts/2024/09/15/index.md
```

## hugo server

`http://localhost:1313/`

```zsh
hugo server
```

### include content marked as draft

```zsh
hugo server -D
```

### include content with publishdate in the future

```zsh
hugo server -F
```

### useful

```zsh
hugo server -D -F
```
