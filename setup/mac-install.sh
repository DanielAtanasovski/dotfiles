#!/bin/bash

# If homebrew is not installed, install it
if ! command -v brew &> /dev/null
then
  echo "Homebrew not found. Installing..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

## Install Brew Packages ##

# if starship is not installed, install it
if ! command -v starship &> /dev/null
then
  echo "Starship not found. Installing..."
  brew install starship
fi


if ! command -v nvim &> /dev/null
then
  echo "Neovim not found. Installing Latest..."
  brew install neovim --HEAD
fi
