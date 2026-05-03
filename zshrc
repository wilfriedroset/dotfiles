export ZSH="${HOME}/.oh-my-zsh"
export ZSH_CUSTOM="${ZSH}-custom"

ZSH_THEME="robbyrussell"

# Heavy completion-generating plugins (docker, docker-compose, helm, podman,
# terraform, zsh-navigation-tools) were dropped to keep startup snappy. The
# CLIs themselves still ship native completions if you want them later.
plugins=(
  brew
  git
  kubectl
  kubectx
  zsh-autosuggestions
)

source "${ZSH}/oh-my-zsh.sh"
unsetopt share_history

[ -f "${HOME}/.shell.rc" ] && source "${HOME}/.shell.rc"

# fzf integration is sourced once from shell.rc.
