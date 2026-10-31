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

Push to `main` — GitHub Actions (`.github/workflows/pages.yml`) builds the site
with Hugo and deploys the compiled output to GitHub Pages. Nothing generated is
committed; `public/` stays gitignored.

Live site: <https://andrewchiw.dev> (custom domain, `static/CNAME`).
Repo: `randomshinichi/randomshinichi.github.io`, Pages source = "GitHub Actions".

| Branch | Contents |
|---|---|
| `main` | Hugo source (this tree) |
| `old-blog` | frozen pre-Hugo static blog (the old `master`) |

Manual rebuild: `gh workflow run pages.yml`. Watch it:
`gh run watch $(gh run list --workflow=pages.yml --limit=1 --json databaseId --jq '.[0].databaseId')`.

Local production build is still just `hugo --gc --minify`, and any static host
works on `public/`.

## Layout

| Path | Purpose |
|---|---|
| `hugo.toml` | site config, menus, PaperMod params |
| `content/posts/` | blog posts |
| `content/about.md` | About page |
| `content/search.md` | PaperMod Fuse search page |
| `scripts/` | theme install + post scaffold |
| `static/CNAME` | custom domain written into the deployed artifact |
