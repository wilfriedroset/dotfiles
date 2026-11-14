---
name: converge
description: Implementer/reviewer subagent protocol and the converge loop. Use for any code change, and for any task with a pass/fail signal (tests, lint, compile, clean plan).
---

The main agent plans, integrates results, and talks to the user. Subagents take work whose middle is noise: file dumps, test logs, search output.

## Roles

- Change across several files, or a long test/fix cycle: an implementer subagent writes the code from a clear spec and returns a diff summary.
- Small change: write it in the main thread.
- Every change: a reviewer subagent with fresh context reads the diff against the spec and the repo conventions, and returns issues. The reviewer is always a new subagent, separate from the implementer and the main thread: same-context review ratifies what was just written.
- If the repo has docs/agents/implementer.md and docs/agents/reviewer.md, give those briefs to the subagents. They override this section.

## Converge loop

Use the loop for an objective signal. Subjective goals (style, naming, architecture) go to the user.

Each iteration:
1. The implementer makes one change toward the goal. Its input is the last signal output and the open blockers.
2. Run the signal command.
3. A fresh reviewer classifies issues:
   - Blocking: correctness, security, a breach of CLAUDE.md, the repo's coding standards, or the stack skill, a broken interface contract, a regression risk the tests miss.
   - Suggestion: a real improvement that is not needed to ship.
   - Nit: style preference.

Exit when the signal is green and the reviewer returns zero blockers. Report suggestions and nits to the user at the end, without iterating on them.

Size each review round to its delta:
- A round that fixes only suggestions or nits, even at the user's request, gets the signal and no reviewer. Merge when the signal is green.
- A round that fixes blockers gets a fresh reviewer with the last reviewed commit and the open blockers. It reads only the diff since that commit, and checks that each blocker is closed.
- Batch the fixes of one review into one round. One reviewer for each small fix commit repeats the setup and the gates for nothing.

Cap: 5 iterations. If the loop is still red after 5, stop and report what is stuck. The usual causes are a wrong spec, a signal that tests the wrong thing, or an implementer/reviewer disagreement that needs a human call.
