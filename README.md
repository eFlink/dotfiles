# dotfiles

Managed with [GNU Stow](https://www.gnu.org/software/stow/). Each top-level
directory is a stow *package* whose contents mirror `$HOME`, so stowing a
package symlinks its files into place.

## Packages

| Package  | Links into            | Notes                                         |
| -------- | --------------------- | --------------------------------------------- |
| `claude` | `~/.claude/`          | `CLAUDE.md`, `settings.json`, hooks           |
| `herdr`  | `~/.config/herdr/`    | `config.toml` only (keybindings); see caveat  |
| `nvim`   | `~/.config/nvim/`     | LazyVim config                                |
| `tmux`   | `~/.config/tmux/`     | includes catppuccin submodule                 |
| `zshrc`  | `~/.zshrc`            |                                               |

## Usage

```sh
# install stow (macOS)
brew install stow

# from the repo root, symlink a package into $HOME
stow tmux
stow nvim herdr zshrc claude

# clone with submodules (tmux catppuccin theme), or pull them after:
git submodule update --init --recursive

# remove a package's symlinks
stow -D tmux

# re-link after adding/moving files
stow -R tmux

# preview without touching the filesystem
stow -n -v tmux
```

## herdr caveat

Only `config.toml` is tracked. herdr's runtime files (sockets, logs,
`session.json`, `agent-detection/`) must stay real files in `~/.config/herdr/`.
stow links `config.toml` individually **only because `~/.config/herdr/` already
exists as a real directory** (stow never folds into an existing dir). On a fresh
machine where that directory doesn't exist yet, `stow herdr` would instead
symlink the whole `~/.config/herdr` directory into this repo, and herdr would
then write its sockets and logs here. To avoid that, let herdr create its config
directory once (run it, or `mkdir -p ~/.config/herdr`) before stowing, or stow
with `--no-folding`.
