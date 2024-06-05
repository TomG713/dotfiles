#!/usr/bin/env bash

set -e

source "$(dirname "$0")/../bin/common.sh"


check_if_exists() {
  local file=$1
  if [ -e "$file" ]; then
    log_warning "$file already exists. Exiting installation."
    exit 0
  fi
}

install_mknetrc_script() {
  local script_path="$HOME/.local/bin/mknetrc"
  log_info "Installing mknetrc script..."

  mkdir -p "$(dirname "$script_path")"
  cp "$(dirname "$0")/mknetrc" "$script_path"
  chmod +x "$script_path"

  log_success "mknetrc script installed at $script_path."
}

add_to_crontab() {
  local script_path="$HOME/.local/bin/mknetrc"
  local crontab_entry="@reboot $script_path\n0 */8 * * * $script_path"

  log_info "Adding mknetrc script to crontab..."

  (crontab -l 2>/dev/null; echo -e "$crontab_entry") | crontab -

  log_success "mknetrc script added to crontab."
}

main() {
  local script_path="$HOME/.local/bin/mknetrc"
  check_if_exists "$script_path"
  install_mknetrc_script
  add_to_crontab
}

main "$@"

