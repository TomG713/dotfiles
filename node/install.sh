#!/usr/bin/env zsh

set -e

source "$(dirname "$0")/../bin/common.sh"

# Ensure the DOTFILES variable is set
[ -z "$DOTFILES" ] && log_error "DOTFILES is not set. Exiting."

# Source NVM plugin
source "$DOTFILES/plugins/nvm.plugin.zsh"

install_node() {
  log_info "Installing and using the latest Node.js with NPM..."
  nvm install node --latest-npm
  nvm use node
}

upgrade_nvm_and_node() {
  log_info "Checking for NVM and Node.js updates..."
  local current_version
  current_version=$(node -v)
  nvm install node --latest-npm

  if [[ "$(node -v)" != "$current_version" ]]; then
    log_info "Upgrading NVM and Node.js..."
    nvm upgrade
  else
    log_info "NVM and Node.js are up to date."
  fi
}

install_and_configure_yarn() {
  if ! command_exists yarn; then
    log_info "Installing Yarn..."
    npm install -g yarn
  fi
  log_info "Configuring Yarn..."
  yarn config set prefix ~/.local
  yarn global add npm webpack yo jest mocha
}

update_yarn_and_global_packages() {
  log_info "Checking for Yarn and global package updates..."
  local updates_needed=false
  local global_packages

  global_packages=$(yarn global list --depth=0 | grep -oP '(?<=info ")(.*)(?=@)')

  for pkg in $global_packages; do
    local latest_version
    latest_version=$(yarn info $pkg version --silent)
    local installed_version
    installed_version=$(yarn global list --pattern "$pkg@" --depth=0 | grep -oP '(?<=info "'$pkg'@)(.*)(?=\")')
    if [ "$latest_version" != "$installed_version" ]; then
      updates_needed=true
      break
    fi
  done

  if $updates_needed; then
    log_info "Updating Yarn and global packages..."
    npm install npm@latest -g
    npm -g update yarn
    yarn global upgrade
    npm -g update
  else
    log_info "Yarn and global packages are up to date."
  fi
}

main() {
  install_node
  upgrade_nvm_and_node
  install_and_configure_yarn
  update_yarn_and_global_packages

  log_success "Node.js, NPM, and Yarn setup completed."
}

main "$@"
