# Migrating from dotbot to chezmoi

The `chezmoi-migration` branch holds a parallel chezmoi tree under
`chezmoi/`, while master continues to serve dotbot from the repo root.
Both can coexist for as long as needed; `master` is the daily-driver
source-of-truth until cutover.

## Repository layout during the parallel period

```
~/.dotfiles/
├── .chezmoiroot          # makes chezmoi treat ./chezmoi as its source
├── bashrc, zshrc, ...    # dotbot source — unchanged
├── install.conf.yaml     # dotbot config — unchanged
├── dotbot/, oh-my-zsh/   # dotbot submodules — unchanged
└── chezmoi/              # chezmoi source — only on chezmoi-migration branch
    ├── .chezmoiexternal.toml
    ├── run_once_install-tools.sh.tmpl
    └── dot_*             # rendered to ~/.* by `chezmoi apply`
```

`.chezmoiroot` lives at the repo root so chezmoi auto-discovers the
subdirectory. Dotbot ignores `.chezmoiroot`, so master is unaffected.

## Cloud / fresh-VM install (chezmoi side)

One command, idempotent:

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- \
    init --apply --branch chezmoi-migration <user-or-repo>
```

That clones the repo at the migration branch, reads `.chezmoiroot`,
renders `chezmoi/dot_*` into `${HOME}`, and fetches the externals
(zsh-autosuggestions, tpm, bash-git-prompt, Vundle, todo extras).

Binaries (fzf, neovim, kubectl, kind, k9s, helm, docker, Go, Node) are
installed by the cloud VM's `user_data.sh` in the sdev-opensource
project — chezmoi only manages files and external git clones. The
user_data.sh's existing `cd ~/.dotfiles && ./install` line will need
to switch to the chezmoi one-liner above when the cutover happens.

Once the migration lands on master, drop `--branch chezmoi-migration`.

## Local testing without flipping the daily driver

Use a separate source dir and a worktree of the migration branch:

```sh
git -C ~/.dotfiles worktree add ~/.local/share/chezmoi-migration chezmoi-migration
chezmoi --source ~/.local/share/chezmoi-migration/chezmoi diff
chezmoi --source ~/.local/share/chezmoi-migration/chezmoi apply
```

`--source` points at the chezmoi subdirectory of the worktree (not the
repo root) since `.chezmoiroot` is only read on the default source path.

Convenient alias while iterating:

```sh
alias czm='chezmoi --source ~/.local/share/chezmoi-migration/chezmoi'
```

The dotbot symlinks at `~/.bashrc`, `~/.zshrc`, etc. will fight with
chezmoi's rendered files on the same host. Either:

1. Test only on a fresh VM (preferred — also exercises the install
   one-liner).
2. On a host you can sacrifice, run `chezmoi apply` and accept that
   subsequent `dotbot install` would overwrite the chezmoi-rendered
   files. Don't do this on the daily driver.

## What changes between master and the branch

- **oh-my-zsh removed.** `dot_zshrc` is bare: cached compinit, lazy
  kubectl completion, `zsh-autosuggestions` sourced directly. Warm
  startup ~20ms vs ~150ms.
- **Plugins from submodules become chezmoi externals.** `apply` clones
  them on first run; refresh weekly via `refreshPeriod = "168h"`.
- **Bash side unchanged.** `bashrc`, `bash_profile`, `bash_aliases`,
  and `git-prompt-colors.sh` are bit-for-bit copies.
- **Cross-shell files unchanged.** `shell.{rc,env,aliases}` are
  copied verbatim.

## Known gaps to verify during testing

1. **No prompt dirty-marker.** `vcs_info`'s `check-for-changes` was
   left off for prompt speed. To re-enable, edit `dot_zsh/prompt.zsh`.
2. **kubectl tab-completion before first invocation.** The lazy stub
   only registers `compdef` after `k …` runs once. Pre-source if the
   one-time delay is annoying.
3. **fzf keybindings.** Installed via apt by `user_data.sh`; `shell.rc`
   sources `~/.fzf.{bash,zsh}` if present. On Debian those files aren't
   shipped by the apt package — keybindings live under
   `/usr/share/doc/fzf/examples/`. Verify `Ctrl-T` / `Ctrl-R` work on a
   fresh VM and adjust the source path if needed.
4. **Per-machine `*.local` files.** Source-if-exists pattern preserved
   everywhere; copy your existing `~/.shell.env.local` etc. by hand
   onto each new host (chezmoi does not manage secrets here).

## Cutover

When confident:

1. Merge `chezmoi-migration` into master.
2. Delete the dotbot tree from the repo root: `bashrc`, `zshrc`,
   `bash_profile`, `bash_aliases`, `shell.*`, `gitconfig`, `tmux.conf`,
   `vimrc`, `screenrc`, `vale.ini`, `markdownlintrc`, `bat.conf`,
   `git-prompt-colors.sh`, `nvim/`, `k9s/`, `tmux/`, `todo/`,
   `todo.actions.d/`, `vim/`, `install`, `install.conf.yaml`,
   `dotbot/` (submodule), `Vundle.vim/` (submodule),
   `oh-my-zsh/` (submodule), `oh-my-zsh-custom/` (submodule).
3. Move `chezmoi/*` and `chezmoi/.chezmoiexternal.toml` up to repo root.
4. Delete `.chezmoiroot`.
5. Update top-level `README.md` with the chezmoi install command.
