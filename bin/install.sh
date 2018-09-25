#!/usr/bin/env bash

git clone https://github.com/rhysormond/dotfiles.git ~/.cfg --bare
alias config='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
config config --local status.showUntrackedFiles no
config reset
config stash
config submodule update --init --recursive

