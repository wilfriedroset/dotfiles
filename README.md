# dotfiles

Personal dotfiles managed by [chezmoi](https://www.chezmoi.io/).

## Install

One command, idempotent:

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply wilfriedroset
```

That installs chezmoi, clones this repo, renders `dot_*` into
`${HOME}`, and fetches the externals declared in
`.chezmoiexternal.toml` (zsh-autosuggestions, tpm, bash-git-prompt,
Vundle, todo.txt extensions).

Binary tools (fzf, neovim, kubectl, kind, k9s, helm, docker, Go) are
provisioned separately by `user_data.sh` in the cloud-VM bootstrap.
chezmoi only manages files and external git clones.

## Day-to-day

| Task | Command |
| --- | --- |
| Sync source from upstream | `chezmoi update` |
| See what would change locally | `chezmoi diff` |
| Apply local source changes | `chezmoi apply` |
| Edit a managed file | `chezmoi edit ~/.zshrc` |
| Drop into the source repo | `chezmoi cd` |

Per-machine secrets and overrides live alongside the managed files
under the `*.local` source-if-exists pattern (`~/.shell.env.local`,
`~/.bashrc.local`, `~/.zshrc.local`, ...). They are intentionally not
tracked.

## Layout

```
.chezmoiexternal.toml       # external git deps (chezmoi clones on apply)
dot_*                       # files rendered to ~/.* by chezmoi
dot_config/                 # rendered to ~/.config/...
dot_zsh/                    # zsh fragments sourced by ~/.zshrc
docs/                       # repo docs
```

## Contributing

Typo / bug / suggestion: https://github.com/wilfriedroset/dotfiles/issues
