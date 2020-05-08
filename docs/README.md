# Setup

These configs are designed to be cloned into a bare repository at `$HOME/.cfg`.

```bash
# clone as a bare repository at $HOME/.cfg
git clone git@github.com:rhysormond/dotfiles.git $HOME/.cfg --bare

# temporary alias for working with a git work tree in $HOME
cfg='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# hide all the untracked files
cfg config --local status.showUntrackedFiles no

# reset and stash local changes
cfg reset && cfg stash

# update submodules (we can use git cfg now that git config has been copied)
git cfg up
```

# Desktop Environment

These configs are designed to be installed on top of Manjaro XFCE.
To get things running:
 - install these config files as discussed above
 - install the dependencies below
 - add `xmonad --replace` triggered `on login` to `xfce4-settings-manager`'s `Session and Startup` > `Application Autostart`
 - disable `Manjaro Hello`' s autostart
 - change the `xfce4-settings-manager`'s `Appearance` > `Style` to `Arc-Gruvbox`
 - change the `xfce4-settings-manager`'s `Desktop` > `Style` to `None`
   if this is not done then `xfce4-panel` will be hidden on startup
 - change the `xfce4-settings-manager`'s settings to remove all desktop icons

# Dependencies

| Name                      | Use                            |
| ------------------------- | ------------------------------ |
| alacritty                 | terminal emulator              |
| diffr                     | diff post-processing           |
| firefox                   | browser                        |
| fish                      | shell                          |
| flameshot                 | screenshot utility             |
| fzy                       | fuzzy finder                   |
| git                       | version control tool           |
| git-extras                | extra git tools                |
| gnupg                     | OpenPGP tool                   |
| gtk-theme-arc-gruvbox-git | gtk gruvbox theme              |
| gvim                      | exitor                         |
| jetbrains-toolbox         | ide                            |
| openssh                   | ssh tools                      |
| otf-fira-code             | monospace font with ligatures  |
| otf-fira-sans             | font                           |
| ripgrep                   | grep replacement               |
| rofi                      | launcher                       |
| slack-desktop             | messaging tool                 |
| tmux                      | terminal multiplexer           |
| xcape                     | keyboard configuration tool    |
| xmonad                    | window manager                 |
| xmonad-contrib            | xmonad utils                   |
| xsel                      | manipulate clipboard           |
| yay                       | package manager                |

