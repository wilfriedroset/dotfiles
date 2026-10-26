# CLAUDE.md

You work on infrastructure and backend systems. If a stack (Go, Terraform/OpenTofu, Puppet, Ansible) has a skill, read it before you write code or run commands in that stack.

---

## Ask before

Stop and confirm before any state-changing action below. Read-only inspection needs no confirmation.

- `terraform apply` / `tofu apply` in any environment, including dev
- `terraform destroy`, `state rm`, `state mv`, or `import`
- `git push --force` or `--force-with-lease` to shared branches
- Deleting or rewriting state files, vault files, anything under `.terraform/`, `.tofu/`
- Modifying CI/CD config
- Generating, rotating, or committing any credential, key, or cert
- `rm -rf` outside the current repo working tree
- Adding a new third-party dependency, with the reason in the commit body
- Anything touching prod inventory, prod state, or prod accounts

If unclear which env a command targets, ask.

---

## Orchestration

The main agent plans, integrates results, and talks to the user. Subagents do work whose middle is noise to the main thread: file dumps, test logs, search results.

For a change across several files or with a long test/fix cycle:
- Implementer subagent: writes the code from a clear spec, returns a diff summary.
- Reviewer subagent: reads the diff against the spec and the repo's conventions, returns a list of issues.

For a small change, write it in the main thread and spawn only the reviewer.

The reviewer is always a fresh subagent, separate from the implementer. Same-context review ratifies what was just written.

### Converge with `/loop`

For tasks with an objective pass/fail signal (tests, lint, compile, clean plan), use `/loop`. If the signal is green AND the reviewer returns no blockers, the loop exits.

Each iteration:
1. Implementer makes a change toward the goal, fed by the previous signal output and blockers.
2. Run the signal command.
3. Reviewer (fresh context) classifies issues:
   - Blocking: correctness, security, violates this file or the relevant skill, breaks an interface contract, regression risk the tests miss.
   - Suggestion: real improvement, not required to ship.
   - Nit: style preference.

Only blockers gate the exit. Report suggestions and nits to the user at the end, without iterating on them.

Cap at 5 iterations. If the loop does not converge, stop and report what is stuck: usually a wrong spec, a signal that tests the wrong thing, or an implementer/reviewer disagreement that needs a human call.

Keep `/loop` for objective goals. Subjective goals (style, naming, architecture) go to the user.

---

## Git

- Conventional commits. The body explains why.
- Atomic commits: each one is tested and `git bisect`-safe.
- Work on a dedicated branch.
- The pre-commit hook rejects common secret patterns (`AKIA*`, `ghp_*`, `eyJ*`, `-----BEGIN`). If it is missing, offer to install it with `prek install`.
- When a change closes a TODO item, update the TODO file in the same commit.

---

## Testing

- TDD: write the failing test first.
- Critical flows get unit + integration + E2E.

---

## Comments

A comment answers why, never what. Default to none. Make the code explain itself through naming and structure.

Write a comment for:
- A non-obvious why: business rule, spec reference, workaround for an external bug, performance trade-off, intentional deviation from the obvious approach.
- A non-local consequence ("called by X under Y condition").
- A link to an issue, RFC, or external doc.

One line is the target. If the why needs more lines than the code, refactor. TODOs carry a ticket reference or owner. The diff records what changed, so comments describe the code as it is. When editing, update or delete nearby comments that no longer match.

---

## Code style

- Plain ASCII in code, comments, and docs: no emojis.
- Docs live under `./docs/` at repo root. Nested layout is fine.
- Structured logs everywhere (Go: `log/slog`).

---

## Privacy

Secrets (API keys, tokens, passwords, JWTs, cloud creds, SSH keys) stay out of logs, commits, and chat. Redact tool output before you quote it. If a secret was committed, report it at once and propose rotation. Leave history as is until the user decides.

---

## Workflow

- `make -C <DIR> <target>` instead of `cd <DIR> && make <target>`.
- When a `make` target exists for a task, use it.

---

## Redacted tokens (pookie)

Tokens like `__PK_TYPE_<hex>__` in code, config, or diffs are intentional redactions of real values. Treat each one as an opaque, immutable handle: copy it verbatim and whole. Reason about the surrounding code, not the hidden value.

---

## Communication

- Terse, direct sentences that start with the content.
- Prefer short synonyms: *big* not *extensive*, *fix* not *implement a solution for*.
- Abbreviate common terms: DB, auth, config, req, res, fn, impl.
- Technical terms stay exact. Code blocks unchanged. Errors quoted exact.
