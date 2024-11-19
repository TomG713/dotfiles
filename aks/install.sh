#!/usr/bin/env bash

set -e

source "$(dirname "$0")/../bin/common.sh"
source "$(dirname "$0")/install-cron.sh"

install_tool() {
  local tool=$1
  local url=$2
  if ! command_exists "$tool"; then
    log_info "Installing $tool..."
    sudo curl -L "$url" -o /usr/local/bin/$tool
    sudo chmod +x /usr/local/bin/$tool
    log_success "$tool installed successfully."
  fi
}

install_docker() {
  if ! command_exists docker; then
    log_info "Installing Docker"
    sudo apt update
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    sudo chmod a+r /etc/apt/keyrings/docker.gpg
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
      $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
      sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt update
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    sudo usermod -aG docker "$USER"
    log_success "Docker installed"
  fi
}

install_azcli() {
  if ! command_exists az; then
    log_info "Installing Azure CLI"
    curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
    log_success "Azure CLI installed"
  fi
}


install_kubectl() {
  if ! command_exists kubectl; then
    log_info "Installing kubectl 1.28"
    sudo apt update
    sudo apt install -y apt-transport-https ca-certificates curl
    curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.28/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
    echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.28/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
    sudo apt update
    sudo apt install -y kubectl
    log_success "kubectl installed"
  fi
}

main() {
  detect_os

  case "$OS" in
    Ubuntu | WSL)
      install_docker
      install_kubectl
      install_azcli
      mknetrc_setup
      ;;
    *)
      ;;
  esac

  install_tool ktx "https://raw.githubusercontent.com/blendle/kns/master/bin/ktx"
  install_tool kns "https://raw.githubusercontent.com/blendle/kns/master/bin/kns"


}

main "$@"
