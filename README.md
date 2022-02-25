# Setup

These configs are designed to be installed on top of Manjaro KDE.

# Config

These configs are cloned into a bare repository with a worktree in `~`.

```fish
# clone as a bare repository at ~/.cfg
git clone git@github.com:rhysormond/dotfiles.git ~/.cfg --bare

# navigate to the newly cloned repo
cd ~/.cfg

# hide all the untracked files
git config --local status.showUntrackedFiles no

# copy files to ~
git --work-tree=$HOME reset --hard
```

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

