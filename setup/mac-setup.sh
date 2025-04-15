#/usr/bin/env zsh 
set -euo pipefail

# Determine the directory where this script is
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# One directory up from where this script is
DOTFILES_DIR="$(dirname "$SCRIPT_DIR")"

# Check for Homebrew and install if needed
if command -v brew >/dev/null 2>&1; then
  echo "\n1. Brew is installed!\n"
else
  echo "\n1. Installing Homebrew...\n"
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Setup Homebrew environment
eval "$(/opt/homebrew/bin/brew shellenv)"

# Check for Git and install if needed
if command -v git >/dev/null 2>&1; then
  echo "\n2. Git is installed!\n"
else
  echo "\n2. Installing Git...\n"
  brew install git
fi

# Install Oh-My-Zsh
if [ -d "$HOME/.oh-my-zsh" ]; then
  echo "\n3. Oh-My-Zsh is already installed!\n"
else
  echo "\n3. Installing 'Oh-My-Zsh'...\n"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Brew packages
echo "\n4. Installing Brew packages...\n"
brew list | grep jetbrains-mono-nerd-font || brew install --cask font-jetbrains-mono-nerd-font
brew list | grep tree || brew install tree 
brew list | grep slack || brew install --cask slack
brew list | grep zen-browser || brew install --cask zen-browser
# brew list | grep tree || brew install 

# Setup Symlinks
echo "\n5. Setting up dotfile symlinks...\n"

# List of dotfiles to link
DOTFILES=(.vimrc .zshrc .gitconfig)
CONFIG_DIR=".config"

for file in "${DOTFILES[@]}"; do
  SRC="$DOTFILES_DIR/$file"
  DEST="$HOME/$file"

  if [ -e "$DEST" ] || [ -L "$DEST" ]; then
    echo " - Skipping $file: already exists at $DEST"
  else
    ln -s "$SRC" "$DEST"
    echo " - Linked $file → $DEST"
  fi
done

# Handle .config directory
SRC="$DOTFILES_DIR/$CONFIG_DIR"
DEST="$HOME/$CONFIG_DIR"

if [ -e "$DEST" ] || [ -L "$DEST" ]; then
  echo " - Skipping $CONFIG_DIR: already exists at $DEST"
else
  ln -s "$SRC" "$DEST"
  echo " - Linked $CONFIG_DIR → $DEST"
fi

