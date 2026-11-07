# Git

- Conventional commits. The body explains why.
- Atomic commits: each one is tested and `git bisect`-safe.
- When a change closes a TODO item, update the TODO file in the same commit.
- If the repo lacks a pre-commit hook that rejects secret patterns (`AKIA*`, `ghp_*`, `eyJ*`, `-----BEGIN`), offer to install it with `prek install`.
