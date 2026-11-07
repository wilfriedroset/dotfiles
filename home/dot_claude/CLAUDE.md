# CLAUDE.md

## Ask before

Confirm each action below before you run it.

- Terraform/OpenTofu `apply` (any env, dev too), `destroy`, `state rm`, `state mv`, `import`
- `git push --force` or `--force-with-lease` to a shared branch
- Deleting or rewriting state files, vault files, `.terraform/`, `.tofu/`
- Changes to CI/CD config
- Generating, rotating, or committing a credential, key, or cert
- `rm -rf` outside the repo working tree
- A new third-party dependency, with the reason in the commit body
- Anything that touches prod inventory, prod state, or prod accounts

If the target env of a command is unclear, ask.

## Secrets

Redact secrets (API keys, tokens, passwords, JWTs, cloud creds, SSH keys) in tool output before you quote it. If a secret was committed, report it at once, propose rotation, and leave history as is until the user decides.

## Redacted tokens (pookie)

Tokens like `__PK_TYPE_<hex>__` in code, config, paths, or diffs are intentional redactions of real values. Treat each one as an opaque, immutable handle: copy it verbatim and whole. Reason about the surrounding code, not the hidden value.

## Work rules

- Review: run every change through the `converge` skill.
- Commits: work on a dedicated branch. Before you commit, read `~/.claude/docs/git.md`.
- Code: follow the repo's CODING_STANDARDS.md and agent briefs. Where they are silent, read `~/.claude/docs/code.md` before you write code.

## Communication

- Terse, direct sentences that start with the content.
- Prefer short synonyms: *big* not *extensive*, *fix* not *implement a solution for*.
- Technical terms stay exact. Code blocks unchanged. Errors quoted exact.
