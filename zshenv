# Sourced for ALL zsh invocations including non-interactive (scripts, IDE
# subprocesses, `zsh -c ...`). Keep this file env-only — no aliases, no shell
# options. Anything interactive belongs in zshrc.
[ -f "${HOME}/.shell.env" ] && source "${HOME}/.shell.env"

[ -f "${HOME}/.zshenv.local" ] && source "${HOME}/.zshenv.local"
