#!/bin/bash

## ALIAS ##

# Kubernetes
alias k='kubectl'
alias vampire-squid='docker pull -q artifactory.reecenet.org:6555/utilities/vampire-squid; docker run --rm -it -u 503:20 -e AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY -e AWS_SESSION_TOKEN -p 8250:8250 -v ~/.vault-tokens:/vault-tokens artifactory.reecenet.org:6555/utilities/vampire-squid'

# Vault
alias vault_login_dev='vampire-squid login --cluster dev oidc && export VAULT_TOKEN=$(cat ~/.vault-tokens/dev) VAULT_ADDR="https://vault-dev.security-nonprod.reecenet.org"'
alias vault_login_dev_admin='vampire-squid login --cluster dev oidc --admin  && export VAULT_TOKEN=$(cat ~/.vault-tokens/dev-admin) VAULT_ADDR="https://vault-dev.security-nonprod.reecenet.org"'
alias vault_login_nonprod='vampire-squid login --cluster nonprod oidc && export VAULT_TOKEN=$(cat ~/.vault-tokens/nonprod) VAULT_ADDR="https://vault.security-nonprod.reecenet.org"'
alias vault_login_nonprod_admin='vampire-squid login --cluster nonprod oidc --admin  && export VAULT_TOKEN=$(cat ~/.vault-tokens/nonprod-admin) VAULT_ADDR="https://vault.security-nonprod.reecenet.org"'
alias vault_login_prod='vampire-squid login --cluster prod oidc && export VAULT_TOKEN=$(cat ~/.vault-tokens/prod) VAULT_ADDR="https://vault.security-prod.reecenet.org"'
alias vault_login_prod_admin='vampire-squid login --cluster prod oidc --admin && export VAULT_TOKEN=$(cat ~/.vault-tokens/prod-admin) VAULT_ADDR="https://vault.security-prod.reecenet.org"'

# Extra
alias vim=nvim
alias ls="eza --icons=always"
alias cd="z"

# Genero
alias launch_genero='open -a /Applications/Genero\ Desktop\ Client\ 3.20.12-202003191410.app/Contents/MacOS/gdc --args -A0 -a -D -M'
