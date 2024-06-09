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

install_wake_script() {
  local script_path="/usr/local/bin/external_monitor_wake"
  log_info "Installing monitor wake script..."

  sudo cp "$(dirname "$0")/external_monitor_wake" "$script_path"
  sudo chmod +x "$script_path"

  log_success "Monitor wake script installed at $script_path."
}

install_systemd_service() {
  local service_file="$(dirname "$0")/wake-monitor.service"
  local service_path="/etc/systemd/system/wake-monitor.service"
  log_info "Copying systemd service file for monitor wake script..."

  sudo cp "$service_file" "$service_path"

  log_success "Systemd service file copied to $service_path."

  log_info "Enabling and starting the wake-monitor service..."
  sudo systemctl daemon-reload
  sudo systemctl enable wake-monitor.service
  sudo systemctl start wake-monitor.service

  log_success "wake-monitor service enabled and started."
}

main() {
  local script_path="/usr/local/bin/external_monitor_wake"
  check_if_exists "$script_path"
  install_wake_script
  install_systemd_service
}

main "$@"
