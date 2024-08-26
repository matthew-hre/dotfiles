#!/usr/bin/env bash

set -e

pushd ~/nix-config/

if git diff --quiet '*.nix'; then
	echo "No changes detected, exiting..."
	popd
	exit 0
fi

alejandra . &>/dev/null \
	|| ( alejandra . ; echo "Formatting failed!" && exit 1)

git diff -U0 '*.nix'

echo "NixOS Rebuilding..."

sudo nixos-rebuild switch &>nixos-switch.log || (cat nixos-switch.log | grep --color error && exit 1)

current=$(nixos-rebuild list-generations | grep current)

git commit -am "$current"

popd

notify-send -e "NixOS Rebuilt!" --icon=software-update-available
