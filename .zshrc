# Amazon Q pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh"
# Q pre block. Keep at the top of this file.
#!/bin/bash

#PROMPT="%B%F{10}%n%f%b:%F{8}%~%f $ "

# Get current script directory (assuming it's a symlink)
ZSHRC_DIR="$(dirname "$(readlink -f "$HOME/.zshrc")")"

# Java version manager
# export PATH="$HOME/.jenv/bin:$PATH"
# eval "$(jenv init -)"

# Node version manager
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Python version manager
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

## ENV ##
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"
export PATH="~/go/bin:$PATH"
export PATH="/usr/local/bin:$PATH"

# Add GNU sed to PATH
export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
export GITHUB_LOCAL_TOKEN=""

# Source other files
source "$HOME/.config/zsh/functions.sh"
source "$HOME/.config/zsh/oh-my-zsh.sh"
source "$HOME/.config/zsh/alias.sh"
source "$HOME/.config/zsh/starship.sh" # This needs to be last

# pnpm
export PNPM_HOME="/Users/atanad/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# Q post block. Keep at the bottom of this file.
# . "/usr/local/opt/asdf/libexec/asdf.sh"
#

#asdf
. /usr/local/opt/asdf/libexec/asdf.sh

# Amazon Q post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh"

