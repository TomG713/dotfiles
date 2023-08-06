#!/usr/bin/env bash

if test ! $(which tailscale)
then
    echo "Install tailscale!"
    echo "go install tailscale.com/cmd/tailscale{,d}@v1.46.1"
    echo "https://github.com/tailscale/tailscale/wiki/Tailscaled-on-macOS"
fi
