# Setup

I use these configs on top of macos.
Clone them directly into `~/.config` with `git clone https://github.com/rhysormond/config.git ~/.config`.

# Dependencies

Install:
 - [homebrew](https://brew.sh/)
 - [docker desktop](https://www.docker.com/products/docker-desktop/)
 - [karabiner elements](https://karabiner-elements.pqrs.org/)

```sh
brew install \
  fish \
  git-delta \
  git-extras \
  jq \
  kitty \
  neovim \
  gpg2 \
  ripgrep \
  tmux
```

# Post-Install

Run `sudo chsh -s /opt/homebrew/bin/fish` to set `fish` as the default shell.
This has to be run with sudo because macos fearfully refuses to let you configure a non-standard shell otherwise.
Make an `~/.env` file to control device-specific environment configuration.
