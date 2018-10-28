# shellcheck source=/dev/null
# SC1090 is not able to follow sourced files and I don't care in bashrc case

alias c='clear'

# Enable some colors
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

if [ -f "${HOME}/.bash_aliases.local" ]; then
    source "${HOME}/.bash_aliases.local"
fi

# vim: set ft=sh:
