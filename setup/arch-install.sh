#!/bin/bash

# Check if ohmyzsh is installed
if [ ! -d ${HOME}/.oh-my-zsh ]; then
    echo "Oh My Zsh not found. Installing..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Check if neovim is installed
if [ ! -f /usr/bin/nvim ]; then
    echo "Nvim not found. Installing..."
    sudo pacman -S neovim-git
fi

# Check if starship is installed
if [ ! -f /usr/bin/starship ]; then
    echo "starship not found. Installing..."
    sudo pacman -S starship
fi