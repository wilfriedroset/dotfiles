# shellcheck source=/dev/null
# SC1090 is not able to follow sourced files and I don't care in bashrc case

alias c='clear'

# Enable some colors if the option is available
# don't care about the output, only to check if the option is available e.g: old
# version on osx
ls --color=auto &> /dev/null
# shellcheck disable=SC2181
if [ $? -eq 0 ]; then
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

if [ -f "${HOME}/.bash_aliases.local" ]; then
    source "${HOME}/.bash_aliases.local"
fi

# vim: set ft=sh:
