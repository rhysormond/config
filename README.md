# Setup

I use these configs on top of macos.
Clone them directly into `~/.config` with `git clone https://github.com/rhysormond/config.git ~/.config`.

# Dependencies

Install:
 - [homebrew](https://brew.sh/)
 - [docker desktop](https://www.docker.com/products/docker-desktop/)
 - [gpgtools](https://gpgtools.org/)
 - [comic code](https://tosche.net/fonts/comic-code)

```sh
brew install \
  fish \
  fzf \
  git-delta \
  git-extras \
  iterm2 \
  jq \
  neovim \
  ripgrep \
  tmux
```

# Post-Install

Convince macos that fish is a shell worth knowing about, then set it as the default.
```sh
sudo sh -c 'echo /opt/homebrew/bin/fish >> /etc/shells'
chsh -s /opt/homebrew/bin/fish
```

Configure iterm2 to read config from `~/.config/iterm2` under Preferences > General > Preferences.

