# Setup

I use these configs on top of Ubuntu Gnome.
Clone them directly into `$XDG_CONFIG_HOME` (e.g. `~/.config`).

# Dependencies

```sh
sudo apt update

sudo apt install \
  fish \
  git-extras \
  kitty \
  ripgrep \
  tmux \
  xcape \
  xsel

# install neovim via PPA
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt-get update
sudo apt-get install neovim

# dpkg install delta via github releases
# see: https://dandavison.github.io/delta/installation.html
```
