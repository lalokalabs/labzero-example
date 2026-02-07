#!/bin/bash
set -e

echo "Installing packages ..."
# Remove old keyring if it exists to avoid "File exists" error
rm -f /usr/share/keyrings/yarn-archive-keyring.gpg

# Use --batch and -o
curl -fsSL https://dl.yarnpkg.com/debian/pubkey.gpg | \
    gpg --batch --dearmor -o /usr/share/keyrings/yarn-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/yarn-archive-keyring.gpg] https://dl.yarnpkg.com/debian stable main" | \
    tee /etc/apt/sources.list.d/yarn.list

# Install uv using the UV_INSTALL_DIR environment variable for system-wide installation
echo "Installing uv..."
# Set the UV_INSTALL_DIR environment variable to /usr/local/bin 
# to force a globally accessible installation path.
# We also use UV_NO_MODIFY_PATH=1 to prevent the script from trying 
# to modify profile files like .bashrc, which is pointless in a Docker RUN context.
curl -LsSf https://astral.sh/uv/install.sh | UV_INSTALL_DIR="/usr/local/bin" UV_NO_MODIFY_PATH=1 sh

# Install Node.js 22.22.0 using nvm
echo "Installing Node.js 22.22.0..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
export NVM_DIR="/usr/local/share/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm install 22.22.0
nvm use 22.22.0
nvm alias default 22.22.0

# Install Mailpit
echo "Installing Mailpit..."
curl -L https://github.com/axllent/mailpit/releases/download/v1.20.5/mailpit-linux-amd64.tar.gz | sudo tar -xz -C /usr/local/bin mailpit

# Install Overmind
echo "Installing Overmind..."
curl -L https://github.com/DarthSim/overmind/releases/download/v2.4.0/overmind-v2.4.0-linux-amd64.gz | gunzip | sudo tee /usr/local/bin/overmind > /dev/null
sudo chmod +x /usr/local/bin/overmind
