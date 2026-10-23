#!/usr/bin/env bash
# Re-install the theme after a `git clone` (themes/ is gitignored).
set -euo pipefail
cd "$(dirname "$0")/.."
mkdir -p themes
if [ ! -d themes/PaperMod/.git ]; then
  rm -rf themes/PaperMod
  git clone --depth 1 https://github.com/adityatelange/hugo-PaperMod themes/PaperMod
fi
# Theme assets need Hugo Modules to be picked up in newer Hugo.
grep -q 'module' go.mod 2>/dev/null || hugo mod init github.com/andrewchiw/andrewchiw.dev >/dev/null 2>&1 || true
if [ ! -f go.mod ]; then hugo mod init github.com/andrewchiw/andrewchiw.dev; fi
grep -q 'hugo-PaperMod' go.mod || hugo mod get github.com/adityatelange/hugo-PaperMod
echo "theme ready"
