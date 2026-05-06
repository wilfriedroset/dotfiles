#!/bin/sh
# Bootstrap script: install chezmoi if absent, then init+apply this repo.
# Pattern lifted from twpayne/dotfiles (the chezmoi author's own bootstrap).

set -eu

if ! chezmoi="$(command -v chezmoi)"; then
    bin_dir="${HOME}/.local/bin"
    chezmoi="${bin_dir}/chezmoi"
    echo "Installing chezmoi to '${chezmoi}'" >&2
    if command -v curl >/dev/null; then
        chezmoi_install_script="$(curl -fsSL get.chezmoi.io)"
    elif command -v wget >/dev/null; then
        chezmoi_install_script="$(wget -qO- get.chezmoi.io)"
    else
        echo "To install chezmoi you must have curl or wget installed." >&2
        exit 1
    fi
    sh -c "${chezmoi_install_script}" -- -b "${bin_dir}"
    unset chezmoi_install_script bin_dir
fi

# POSIX way to get the script's own directory.
script_dir="$(cd -P -- "$(dirname -- "$(command -v -- "$0")")" && pwd -P)"

set -- init --apply --source="${script_dir}"

echo "Running 'chezmoi $*'" >&2
exec "$chezmoi" "$@"
