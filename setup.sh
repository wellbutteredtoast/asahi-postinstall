#!/usr/bin/env bash
# Asahi Linux postinall setup script
# Should be run *once you're in the DE*
#
# (c) 2025 wellbutteredtoast

set -euo

info() { echo -e "\033[1;34m[INFO]\033[0m $*"; }
ok()   { echo -e "\033[1;32m[OK  ]\033[0m $*"; }
err()  { echo -e "\033[1;31m[ERR ]\033[0m $*"; }

clear
info "Updating system..."
sudo dnf update -y > /dev/null

info "Installing DevTools Group..."
sudo dnf groupinstall -y "Development Tools" > /dev/null

info "Installing Clang..."
sudo dnf install -y clang clang++ > /dev/null

info "Installing Build tools..."
sudo dnf install -y cmake ninja-build > /dev/null

info "Installing Python 3.13..."
sudo dnf install -y python3 python3-pip python3-venv > /dev/null

# Curl into and install Rust if not found
if ! command -v rustc >/dev/null 2>&1 then
	info "Fetching Rust toolchain..."
	# curl command yoinked right from rust-lang.org
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustiup.rs | sh -s -- -y
	source "$HOME/.cargo/env"
else
	ok "Rust is already on the system."
fi

# Fetch Lua and its luarocks pkg system
info "Installing Lua + Luarocks..."
sudo dnf install -y lua lua-devel luarocks > /dev/null

# Misc but good tui utils
info "Installing utility packages..."
sudo dnf install -y git neovim htop tmux > /dev/null

info "Installing GNOME Tweaks..."
sudo dnf install -y gnome-tweaks gnome-extensions-app > /dev/null

ok "Setup complete, enjoy your new system!"
sleep 5

