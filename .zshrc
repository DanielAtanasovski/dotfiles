#!/bin/bash

#PROMPT="%B%F{10}%n%f%b:%F{8}%~%f $ "

# Get current script directory (assuming it's a symlink)
ZSHRC_DIR="$(dirname "$(readlink -f "$HOME/.zshrc")")"

# Java version manager
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

# Node version manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Python version manager
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

## ENV ##
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"
export PATH="~/go/bin:$PATH"

# Add GNU sed to PATH
export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"

# Source other files
source "${ZSHRC_DIR}"/zsh-extra/alias.sh
source "${ZSHRC_DIR}"/zsh-extra/functions.sh
source "${ZSHRC_DIR}"/zsh-extra/oh-my-zsh.sh
source "${ZSHRC_DIR}"/zsh-extra/starship.sh # This needs to be last
