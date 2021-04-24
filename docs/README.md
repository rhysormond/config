# Setup

These configs are designed to be cloned into a bare repository with a worktree in `~`.

```fish
# clone as a bare repository at ~/.cfg
git clone git@github.com:rhysormond/dotfiles.git ~/.cfg --bare

# navigate to the newly cloned repo
cd ~/.cfg

# hide all the untracked files
git config --local status.showUntrackedFiles no

# copy files from git to ~
git --work-tree=$HOME reset --hard
```

# Desktop Environment

These configs are designed to be installed on top of Manjaro XFCE minimal.
To get things running:
 - install these config files as outlined above
 - install the dependencies below

# Dependencies

Before installing the below packages `base-devel` and `binutils` need to be installed.

| Name                      | Use                            |
| ------------------------- | ------------------------------ |
| alacritty                 | terminal emulator              |
| diffr                     | diff post-processing           |
| firefox                   | browser                        |
| fish                      | shell                          |
| fisher                    | fish plugin manager            |
| flameshot                 | screenshot utility             |
| fzf                       | fuzzy finder                   |
| git                       | version control tool           |
| git-extras                | extra git tools                |
| gnupg                     | OpenPGP tool                   |
| neovim-nightly            | editor                         |
| imwheel                   | mouse tweaker                  |
| jetbrains-toolbox         | ide                            |
| openssh                   | ssh tools                      |
| ttf-fira-code             | monospace font with ligatures  |
| otf-fira-sans             | font                           |
| pa-applet                 | pulse audio applet             |
| polybar                   | status bar                     |
| redshift                  | display color manager          |
| ripgrep                   | grep replacement               |
| rofi                      | launcher                       |
| slack-desktop             | messaging tool                 |
| tmux                      | terminal multiplexer           |
| xcape                     | keyboard configuration tool    |
| xmonad                    | window manager                 |
| xmonad-contrib            | xmonad utils                   |
| xsel                      | manipulate clipboard           |
| yay                       | package manager                |

