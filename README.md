# Setup

I use these configs on top of Manjaro KDE.
Clone them directly into `$XDG_CONFIG_HOME` (e.g. `~/.config`).

# Dependencies

```fish
# install an ergonomic pacman wrapper
sudo pacman -S yay

# tell yay to always update git packages
yay --save --devel

# install build dependencies
yay -S base-devel binutils

# install everything else
yay -S \
  fish \
  fisher \
  git-delta \
  git-extras \
  kitty \
  neovim-git \
  ripgrep \
  tmux \
  ttf-fira-code \
  xcape \
  xsel
```
