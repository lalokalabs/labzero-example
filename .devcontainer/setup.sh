#!/bin/bash
set -e

echo "Setting up development environment..."
npm install
cp .env.example .env

# Update PATH and nvm configuration
echo "Updating PATH and nvm configuration..."
echo 'export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$PATH"' >> ~/.bashrc
echo 'export NVM_DIR="/usr/local/share/nvm"' >> ~/.bashrc
echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> ~/.bashrc
echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"' >> ~/.bashrc

echo "Development environment setup complete!"
