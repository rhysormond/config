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
git cfg submodule update --init --recursive
```

# Dependencies

| Name                      | Use                            |
| ------------------------- | ------------------------------ |
| yay                       | package manager                |
| alacritty                 | terminal emulator              |
| diffr                     | diff post-processing           |
| dunst                     | notification daemon            |
| firefox                   | browser                        |
| fish                      | shell                          |
| flameshot                 | screenshot utility             |
| fzy                       | fuzzy finder                   |
| git                       | version control tool           |
| git-extras                | extra git tools                |
| acpi                      | power monitoring               |
| gvim                      | exitor                         |
| xmonad                    | window manager                 |
| xmonad-contrib            | xmonad utils                   |
| wmctrl                    | window manager scripting util  |
| lightdm                   | display manager                |
| lightdm-gtk-greeter       | greeter                        |
| networkmanager            | network manager                |
| networkmanager-dmenu      | dmenu networkmanager interface |
| xorg-xsetroot             | wallpaper setter               |
| openssh                   | ssh tools                      |
| otf-fira-code             | monospace font with ligatures  |
| otf-fira-sans             | font                           |
| gtk-theme-arc-gruvbox-git | gtk gruvbox theme              |
| polybar                   | status bar                     |
| rofi                      | application launcher           |
| tmux                      | terminal multiplexer           |
| ripgrep                   | grep replacement               |
| pulseaudio                | sound server                   |
| xcape                     | keyboard configuration tool    |
| xfce4-power-manager       | power settings manager         |
| xorg-xbacklight           | backlight configuration tool   |
| xsecurelock               | screen locker                  |
| xss-lock                  | session locker                 |
| slack-desktop             | messaging tool                 |
| jetbrains-toolbox         | ide                            |

