# Robbyrussell-equivalent prompt without the omz framework.
# Format:  ➜ <last-dir>  git:(<branch>)
# Arrow turns red on non-zero exit. Branch shown only inside a git repo.

autoload -Uz vcs_info
precmd() { vcs_info }

# Only enable git; everything else is a wasted backend probe.
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats       ' %F{blue}git:(%F{red}%b%F{blue})%f'
zstyle ':vcs_info:git:*' actionformats ' %F{blue}git:(%F{red}%b|%a%F{blue})%f'

setopt prompt_subst
PROMPT='%(?:%F{green}➜ :%F{red}➜ ) %F{cyan}%c%f${vcs_info_msg_0_} '
