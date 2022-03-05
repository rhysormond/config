# Setup

I use these configs on top of Manjaro KDE.
Clone them directly into `$XDG_CONFIG_HOME` (e.g. `~/.config`).

# Dependencies

```fish
# install an ergonomic pacman wrapper
sudo pacman -S yay

# install build dependencies
yay -S base-devel binutils

# install everything else
yay -S \
  alacritty \
  diffr \
  fish \
  fisher \
  git-extras \
  neovim-git \
  ttf-fira-code \
  ripgrep \
  tmux \
  xcape \
  xsel
```
