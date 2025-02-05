# Setup

I use these configs on top of macos.
Clone them directly into `~/.config` with `git clone git@github.com:rhysormond/config.git ~/.config`.

# Dependencies
 - [homebrew](https://brew.sh/)
 - [docker desktop](https://www.docker.com/products/docker-desktop/)
 - [iTerm2](https://iterm2.com)
 - [comic code](https://tosche.net/fonts/comic-code)

# Post-install

Configure Iterm2 to use the correct config
```sh
defaults write com.googlecode.iterm2 PrefsCustomFolder -string "~/.config/iterm2"
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true
```

Symlink zsh env vars since it doesn't respect the XDG base directory spec
```sh
ln -Fis ~/.config/zsh/.zshenv ~/.zshenv
```

Install tmux
```sh
brew install tmux
```
