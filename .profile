#!/usr/bin/env sh

export PATH="${HOME}/bin:${PATH}"

export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"

export VIMINIT=":source $XDG_CONFIG_HOME"/vim/vimrc

export XMONAD_CACHE_DIR="${XDG_CACHE_HOME}/xmonad"
export XMONAD_CONFIG_DIR="${XDG_CONFIG_HOME}/xmonad"
export XMONAD_DATA_DIR="${XDG_DATA_HOME}/xmonad"

export BROWSER="firefox"
export VISUAL="vim"
export EDITOR="${VISUAL}"

# hidpi display
export QT_AUTO_SCREEN_SCALE_FACTOR=1
export GDK_SCALE=2
