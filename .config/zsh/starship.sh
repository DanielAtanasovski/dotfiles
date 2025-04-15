#!/bin/bash

# Check if starship is installed
if ! command -v starship &> /dev/null
then
    echo "[STARTUP] starship could not be found, please install it first."
    return 0
fi

export STARSHIP_CONFIG="${HOME}/.config/starship/starship.toml"
eval "$(starship init zsh)"
