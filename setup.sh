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
if [ ! -L "${HOME_DIR}/.config/kitty/kitty.conf" ]; then
  echo "Symlinking kitty.conf..."
  mkdir -p "${HOME_DIR}/.config/kitty"
  ln -s "${DOTFILES_DIR}/kitty/kitty.conf" "${HOME_DIR}/.config/kitty/kitty.conf"
  ln -s "${DOTFILES_DIR}/kitty/nord.conf" "${HOME_DIR}/.config/kitty/nord.conf"
fi

if [ ! -L "${HOME_DIR}/.config/wezterm" ]; then
  echo "Symlinking wezterm config"
  ln -s "${DOTFILES_DIR}/.config/wezterm" "${HOME_DIR}/.config/wezterm"
fi

if [ ! -L "${HOME_DIR}/.tmux.conf" ]; then
  echo "Symlinking .tmux.conf..."
  ln -s "${DOTFILES_DIR}/terminals/.tmux.conf" "${HOME_DIR}/.tmux.conf"
fi

if [ ! -L "${HOME_DIR}/.config/starship" ]; then
  echo "Symlinking starship config..."
  ln -s "${DOTFILES_DIR}/.config/starship" "${HOME_DIR}/.config/starship"
fi

if [ ! -L "${HOME_DIR}/.config/zsh" ]; then
  echo "Symlinking zsh config..."
  ln -s "${DOTFILES_DIR}/.config/zsh" "${HOME_DIR}/.config/zsh"
  ln -s "${DOTFILES_DIR}/.zshrc" "${HOME_DIR}/.zshrc"
fi

# If MacOS, run install mac-install.sh
if [[ "$OSTYPE" == "darwin"* ]]; then
  echo "MacOS detected. Running MacOS install script..."
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
