# Git

- Conventional commits. The body explains why.
- Atomic commits: each one is tested and `git bisect`-safe.
- When a change closes a TODO item, update the TODO file in the same commit.
- If the repo lacks a pre-commit hook that rejects secret patterns (`AKIA*`, `ghp_*`, `eyJ*`, `-----BEGIN`), offer to install it with `prek install`.
- If a commit fails with `No pinentry`, the gpg-agent cache expired. Stop and ask the user to run `echo | gpg2 --clearsign -u "$(git config user.signingkey)" >/dev/null` in another terminal. Retry the commit once after they confirm.
