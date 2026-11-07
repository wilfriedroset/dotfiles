# Code

Fallback rules for a repo whose CODING_STANDARDS.md and agent briefs are silent. The repo wins on any conflict.

## General

- Write plain ASCII in code, comments, and docs.
- Docs live under `./docs/` at repo root. Nested layout is fine.
- Structured logs everywhere (Go: `log/slog`).
- Write the failing test first. Critical flows get unit, integration, and E2E tests.
- Run `make -C <DIR> <target>` from where you are. When a `make` target exists for a task, use it.

## Comments

Default to none. Naming and structure carry the what. Doc comments on public API follow the language convention (Go: Effective Go) and can span lines.

Write a comment for:
- A non-obvious why: business rule, spec reference, workaround for an external bug, performance trade-off, intentional deviation from the obvious approach.
- A non-local consequence ("called by X under Y condition").
- A link to an issue, RFC, or external doc.

One line is the target. If the why needs more lines than the code, refactor. TODOs carry a ticket reference or owner. The diff records what changed, so comments describe the code as it is. When editing, update or delete nearby comments that no longer match.
