# andrewchiw.dev

Hugo blog, [PaperMod](https://github.com/adityatelange/hugo-PaperMod) theme. Hugo extended v0.165+.

## Local dev

```bash
./scripts/install-theme.sh   # first time only (themes/ is gitignored)
hugo server -D               # http://localhost:1313
```

`-D` includes `draft: true` posts so you can preview work in progress.

## New post

```bash
./scripts/new-post.sh my-slug     # → content/posts/my-slug.md (draft: true)
```

Set `draft: false` to publish. Front matter supports `title`, `date`,
`description` (used for the post card + meta), `tags`, `categories`.

## Build

```bash
hugo --gc --minify     # → public/
```

Draft source lives outside this repo; published copies are committed here.

## Deploy

Any static host works on `public/`. GitHub Pages example:

```bash
hugo --gc --minify && rsync -a --delete public/ <deploy-target>/
```

Set `baseURL` in `hugo.toml` to the real origin before deploying (currently
`https://andrewchiw.dev/`). For a `*.github.io` project site, use
`baseURL = 'https://<user>.github.io/<repo>/'`.

## Layout

| Path | Purpose |
|---|---|
| `hugo.toml` | site config, menus, PaperMod params |
| `content/posts/` | blog posts |
| `content/about.md` | About page |
| `content/search.md` | PaperMod Fuse search page |
| `scripts/` | theme install + post scaffold |
