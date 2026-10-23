#!/usr/bin/env bash
# New post scaffold: ./scripts/new-post.sh my-slug
set -euo pipefail
cd "$(dirname "$0")/.."
[ -n "${1:-}" ] || { echo "usage: $0 <slug>"; exit 1; }
hugo new content "posts/${1}.md"
