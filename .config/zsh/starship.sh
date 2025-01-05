#!/bin/bash
export STARSHIP_CONFIG="${HOME}/.config/starship/starship.toml"
# export STARSHIP_LOG=trace starship module kubernetes


# Start starship
eval "$(starship init zsh)"
