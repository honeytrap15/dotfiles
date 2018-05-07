#!/bin/bash

TMUX_CONF=~/.tmux.conf
ZSH_CONF=~/.zshrc
NVIM_CONF=~/.config/nvim
CONF_DIR=$(cd $(dirname ${0}); pwd)
CUI_CONF_BIN_DIR=~/.cui-conf-bin

function create_link () {
  echo "ln -nfs $CONF_DIR/$1 $2"
  ln -nfs $CONF_DIR/$1 $2
}


if [ -e $TMUX_CONF ]; then
  echo ".tmux.conf is exists."
else
  echo "create tmux.conf link"
  create_link tmux/tmux.conf $TMUX_CONF
fi

if [ -e $ZSH_CONF ]; then
  echo ".zshrc is exists."
else
  echo "create .zshrc link"
  create_link zsh/zshrc $ZSH_CONF
fi

if [ -e $NVIM_CONF ]; then
  echo ".config/nvim is exists."
else
  echo "create nvim link"
  if [ ! -e ~/.config ]; then
    mkdir ~/.config
  fi
  if [ ! -e ~/nvim ]; then
    mkdir ~/nvim
  fi
  create_link nvim $NVIM_CONF
fi

if [ -e $CUI_CONF_BIN_DIR ]; then
  echo "cui-conf bin is exists."
else
  echo "create cui-conf bin link"
  create_link scripts $CUI_CONF_BIN_DIR
fi

