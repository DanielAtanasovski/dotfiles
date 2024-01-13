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
  ln -s "${DOTFILES_DIR}/.vimrc" "${HOME_DIR}/.vimrc"
fi

if [ ! -e "${HOME_DIR}/.zshrc" ]; then
  ln -s "${DOTFILES_DIR}/.zshrc" "${HOME_DIR}/.zshrc"
fi

# If MacOS, run install mac-install.sh
if [[ "$OSTYPE" == "darwin"* ]]; then
  "${DOTFILES_DIR}"/setup/mac-install.sh
fi
