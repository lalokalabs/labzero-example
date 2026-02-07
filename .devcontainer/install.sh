#!/bin/bash
set -e

# Detect if sudo is needed and available
if [ "$(id -u)" -ne 0 ]; then
    SUDO="sudo"
else
    SUDO=""
fi

echo "Cleaning up old repository files..."
# Remove the problematic yarn list if it exists from previous attempts
$SUDO rm -f /etc/apt/sources.list.d/yarn.list
$SUDO rm -f /usr/share/keyrings/yarn-archive-keyring.gpg

echo "Updating and installing system packages..."
$SUDO apt-get update
$SUDO apt-get install -y tmux

# --- UV (Python Package Manager) ---
echo "Installing uv..."
curl -LsSf https://astral.sh/uv/install.sh | UV_INSTALL_DIR="/usr/local/bin" UV_NO_MODIFY_PATH=1 sh

# --- Node.js via NVM ---
echo "Installing Node.js..."
export NVM_DIR="$HOME/.nvm"
# If in a devcontainer/system-wide context, you might prefer /usr/local/share/nvm
# but for local users, $HOME/.nvm is the standard.
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm install 22.22.0
nvm alias default 22.22.0

# --- Mailpit ---
echo "Installing Mailpit..."
curl -L https://github.com/axllent/mailpit/releases/download/v1.20.5/mailpit-linux-amd64.tar.gz | $SUDO tar -xz -C /usr/local/bin mailpit

# --- Overmind ---
echo "Installing Overmind..."
curl -L https://github.com/DarthSim/overmind/releases/download/v2.4.0/overmind-v2.4.0-linux-amd64.gz | gunzip | $SUDO tee /usr/local/bin/overmind > /dev/null
$SUDO chmod +x /usr/local/bin/overmind

echo "Setup complete! Please restart your terminal or source your profile."