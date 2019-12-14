#!/usr/bin/env bash

# clones dotfiles into a bare repository $HOME/.cfg
git clone git@github.com:rhysormond/dotfiles.git $HOME/.cfg --bare

# define a git alias to reference $HOME/.cfg with a work-tree in $HOME
cfg='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# hide all the untracked files
cfg config --local status.showUntrackedFiles no

# reset and stash local changes
cfg reset && cfg stash

# update submodules (vim plugins)
git submodule update --init --recursive
