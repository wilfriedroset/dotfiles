export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(
  brew
  docker
  docker-compose
  git
  helm
  kubectl
  podman
  terraform
  zsh-navigation-tools
)

source $ZSH/oh-my-zsh.sh
unsetopt share_history

export LANG=en_US.UTF-8

[ -f "${HOME}/.shell.rc" ] && source "${HOME}/.shell.rc"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
