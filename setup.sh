#!/bin/bash
set -e

## PREPARE ##
# Get this script's directory
DOTFILES_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
# Get user's home directory
HOME_DIR="$( eval echo ~"$USER" )"

## SYMLINK ##
# Only symlink files that don't already exist
if [ ! -e "${HOME_DIR}/.vimrc" ]; then
  echo "Symlinking .vimrc..."
  ln -s "${DOTFILES_DIR}/.vimrc" "${HOME_DIR}/.vimrc"
fi

if [ ! -e "${HOME_DIR}/.zshrc" ]; then
  echo "Symlinking .zshrc..."
  ln -s "${DOTFILES_DIR}/.zshrc" "${HOME_DIR}/.zshrc"
fi

# Symlink Kitty config
if [ ! -e "${HOME_DIR}/.config/kitty/kitty.conf" ]; then
  echo "Symlinking kitty.conf..."
  mkdir -p "${HOME_DIR}/.config/kitty"
  ln -s "${DOTFILES_DIR}/kitty/kitty.conf" "${HOME_DIR}/.config/kitty/kitty.conf"
  ln -s "${DOTFILES_DIR}/kitty/nord.conf" "${HOME_DIR}/.config/kitty/nord.conf"
if [ ! -e "${HOME_DIR}/.wezterm.lua" ]; then
  ln -s "${DOTFILES_DIR}/terminals/.wezterm.lua" "${HOME_DIR}/.wezterm.lua"
fi

if [ ! -e "${HOME_DIR}/.tmux.conf" ]; then
  ln -s "${DOTFILES_DIR}/terminals/.tmux.conf" "${HOME_DIR}/.tmux.conf"
fi

# If MacOS, run install mac-install.sh
if [[ "$OSTYPE" == "darwin"* ]]; then
  "${DOTFILES_DIR}"/setup/mac-install.sh
fi

# If Linux, determine distro and run install it's install script
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  if [ -f /etc/os-release ]; then
    # freedesktop.org and systemd
    . /etc/os-release
    if [[ "$ID" == "arch" || "$ID_LIKE" == "arch" ]]; then
      echo "Arch Linux detected. Running Arch install script..."
      "${DOTFILES_DIR}"/setup/arch-install.sh
    fi
  fi
fi


echo "Setup complete!"
