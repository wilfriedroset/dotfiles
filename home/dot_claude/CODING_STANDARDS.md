# Coding standards

## Code

- Plain ASCII in code, comments, and docs.
- Docs go under `./docs/` at repo root.
- Logs are structured (Go: `log/slog`).
- If a `make` target exists for a task, run it as `make -C <dir> <target>`.

## Tests

- TDD: write the failing test first.
- Critical flows get unit, integration, and E2E tests.

## Comments

- A comment answers why, never what.
- A comment describes the code as it is. The diff records the change.
- A TODO carries a ticket or an owner.
- When you change code, fix or delete nearby comments that no longer match.

## Commits

- Conventional commits. The body says why.
- Each commit is atomic and bisect-safe.
- A change that closes a TODO item updates the TODO file in the same commit.
- If `.git/hooks/pre-commit` is missing, offer `prek install`: the hook blocks secret patterns.

## Review

Every change gets a reviewer in a fresh subagent: same-context review ratifies what was just written. The reviewer sorts issues into blockers (correctness, security, contract break, regression risk the tests miss, a breach of this file), suggestions, and nits. Fix blockers and re-review, at most 5 rounds. If blockers remain, stop and report what is stuck. Report suggestions and nits at the end, unfixed.
