# CLAUDE.md

## Ask first

Before an action on this list, show the exact command and wait for a yes. Read-only commands run freely.

- Terraform/OpenTofu `apply` (dev too), `destroy`, `state rm`, `state mv`, `import`.
- Editing or deleting state files, vault files, `.terraform/`, `.tofu/`.
- Prod inventory, state, or accounts. A command whose target env is unclear counts as prod.
- Generating, rotating, or committing a credential, key, or cert.
- `git push --force` or `--force-with-lease` to a shared branch.
- CI/CD config changes.
- `rm -rf` outside the repo working tree.
- A new third-party dependency. Its reason goes in the commit body.

## Secrets

Redact secrets from tool output before you quote it, and keep them out of logs and commits. If a secret was committed, report it at once and propose rotation. Leave history as is until the user decides.

## Redacted tokens (pookie)

Tokens like `__PK_TYPE_<hex>__` in code, config, paths, or diffs are intentional redactions of real values. Treat each one as an opaque, immutable handle: copy it verbatim and whole. Reason about the surrounding code, not the hidden value.

## Coding

Before you edit code or docs, or commit, read `~/.claude/CODING_STANDARDS.md`. If the repo has its own `CODING_STANDARDS.md`, read it too. On conflict, the repo's rules win.
