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
| slack-desktop             | messaging tool                 |
| tmux                      | terminal multiplexer           |
| wmctrl                    | window manager scripting util  |
| xcape                     | keyboard configuration tool    |
| xmonad                    | window manager                 |
| xmonad-contrib            | xmonad utils                   |
| xorg-xbacklight           | backlight configuration tool   |
| xorg-xsetroot             | wallpaper setter               |
| xsecurelock               | screen locker                  |
| xsel                      | manipulate clipboard           |
| xss-lock                  | session locker                 |
| yay                       | package manager                |

