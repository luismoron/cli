#!/bin/bash

# Automated installation script for Caelestia CLI on Fedora
# This script installs Hyprland and the CLI dependencies, then builds and installs the CLI.

set -e

echo "Starting automated installation for Caelestia CLI on Fedora..."

# Enable COPR for Hyprland
echo "Enabling COPR repository for Hyprland..."
sudo dnf copr enable solopasha/hyprland -y

# Install Hyprland and related packages
echo "Installing Hyprland..."
sudo dnf install hyprland hyprpaper hyprlock -y

# Enable RPM Fusion repositories for additional dependencies
echo "Enabling RPM Fusion repositories..."
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm -y
sudo dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y

# Install CLI dependencies
echo "Installing CLI dependencies..."
sudo dnf install libnotify swappy grim sassc wl-clipboard slurp glib2 cliphist fuzzel python3-build python3-installer python3-hatch python3-hatch-vcs -y

# Install gpu-screen-recorder if available
echo "Installing gpu-screen-recorder..."
sudo dnf install gpu-screen-recorder -y || echo "gpu-screen-recorder not available, skipping..."

# Note: app2unit may not be available, skip or handle manually
echo "Note: app2unit is not available in Fedora repositories. You may need to install it manually or find an alternative."

# Clone the repo if not already cloned
if [ ! -d "cli" ]; then
    echo "Cloning the CLI repository..."
    git clone https://github.com/caelestia-dots/cli.git
    cd cli
else
    echo "CLI repository already exists, updating..."
    cd cli
    git pull
fi

# Build and install the CLI
echo "Building and installing the CLI..."
python3 -m build --wheel
sudo python3 -m installer dist/*.whl

# Install fish completions
echo "Installing fish completions..."
sudo cp completions/caelestia.fish /usr/share/fish/vendor_completions.d/caelestia.fish

echo "Installation completed successfully!"
echo "You can now use 'caelestia' command."
echo "Make sure to configure your Hyprland setup and copy the dotfiles."