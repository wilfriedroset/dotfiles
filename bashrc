# shellcheck source=/dev/null
# SC1090 is not able to follow sourced files and I don't care in bashrc case

# If not running interactively, don't do anything
case $- in
    *i*) ;;
    *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    # shellcheck disable=SC1091
    source /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    # shellcheck disable=SC1091
    source /etc/bash_completion
  fi
  if [ -f "${HOME}/.local/etc/bash_completion" ]; then
      source "${HOME}/.local/etc/bash_completion"
  fi
fi

# Let's have a useful prompt
source ~/.liquidprompt/liquidprompt

if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

export EDITOR=vim

PATH="${HOME}/.local/bin:${PATH}"
export PATH

# Setup SSH agent
setup_ssh_agent(){
    if [ -n "${SSH_AUTH_SOCK+x}" ]; then
        ssh-add -L > /dev/null # don't care about the output
        # shellcheck disable=SC2181
        if [ $? -ne 0 ]; then
            ssh-add -q -t 36000
        fi
    fi
}

# export the function to be usable in shell as a command
export -f setup_ssh_agent

# OSX specific bashrc
if [[ "$OSTYPE" == "darwin"* ]] && [[ -f ~/.osx/bashrc ]]; then
    source ~/.osx/bashrc
fi

if [ -f ~/.bashrc.local ]; then
    source ~/.bashrc.local
fi

# Call last to allow CTRL-C
setup_ssh_agent
