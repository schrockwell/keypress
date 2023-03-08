# Keypress

Keypress is the LiveView microblog application that powers [posts.schrockwell.com](https://posts.schrockwell.com).

## Features

- Three post types: short, long, and link
- Markdown
- Open Graph meta tags
- LiveView post editor with previews
  - Drafts
  - Edits
- RSS

## Planned Features

See [GitHub issues](https://github.com/schrockwell/keypress/issues?q=is%3Aopen+is%3Aissue+label%3Aenhancement).

- Pagination

## Unplanned Features

- Multiple authors
- Tags
- Comments
- Image upload

# Development

```sh
mix setup

# Seed some fake data
mix run priv/repo/examples.exs
```

## Environment Variables

See `.envrc-example`.

- `AUTHOR_PASSWORD` - the HTTP basic authentication password for administration at `/posts`. The admin username is empty.

# Deployment

Files are included to deploy it to Dokku
