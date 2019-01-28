# Configuration Files
A set of configuration and scripts to roughly recreate my development environment from scratch.

## Install Dependencies
```bash
pacman -S yay
yay -S
    alacritty
    firefox
    fzy
    git
    gtk-theme-arc-gruvbox-git
    gvim
    networkmanager
    network-manager-applet
    nitrogen
    openssh
    polybar
    pulseaudio
    ranger
    ripgrep
    rofi
    rsync
    screengrab
    tmux
    terminus-font
    tree
    ttf-dejavu
    xautolock
    xfce4-power-manager
    xorg-xbacklight
    zsh
```

## Install Configuration
```bash
git clone https://github.com/rhysormond/dotfiles.git ~/.cfg --bare
alias config='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
config config --local status.showUntrackedFiles no
config reset
config stash
config update
```

