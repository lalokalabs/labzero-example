#!/bin/bash

# Sync dependencies with uv
echo "Syncing dependencies with uv..."
uv sync

# Install npm dependencies
echo "Installing npm dependencies..."
npm install

echo "Installation complete!"
