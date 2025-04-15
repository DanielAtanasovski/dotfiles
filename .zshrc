#!/bin/env bash

# Get current script directory (assuming it's a symlink)
ZSHRC_DIR="$(dirname "$(readlink -f "$HOME/.zshrc")")"

## ENV ##
export PATH="/usr/local/bin:$PATH" # Homebrew
export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH" # GNO-SED

# Brew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Source other files
source "$HOME/.config/zsh/functions.sh"
source "$HOME/.config/zsh/tools.sh"
source "$HOME/.config/zsh/alias.sh"
source "$HOME/.config/zsh/oh-my-zsh.sh"
source "$HOME/.config/zsh/starship.sh" # This needs to be last

#asdf
if command -v asdf &> /dev/null; then
  . /usr/local/opt/asdf/libexec/asdf.sh
fi

