#!/usr/bin/env bash

source "$(dirname "$0")/../bin/common.sh"

log_info "Setting reasonable macOS defaults..."

defaults write -g ApplePressAndHoldEnabled -bool false
defaults write com.apple.NetworkBrowser BrowseAllInterfaces 1
defaults write com.apple.Finder FXPreferredViewStyle Nlsv
chflags nohidden ~/Library
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true
defaults write com.apple.dock wvous-bl-corner -int 5
defaults write com.apple.dock wvous-bl-modifier -int 0
defaults write com.apple.Safari ShowFavoritesBar -bool false
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false
defaults write NSGlobalDomain AppleFontSmoothing -int 2
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

log_success "macOS defaults set."
