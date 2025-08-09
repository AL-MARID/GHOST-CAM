#!/bin/bash

# --- Install Ruby ---
if command -v ruby >/dev/null 2>&1; then
  echo "Ruby is already installed. No need to install."
else
  echo "Ruby not found. Installing..."

  if command -v apt >/dev/null 2>&1; then
    sudo apt update && sudo apt install -y ruby-full && echo "Ruby installation successful." || echo "Ruby installation failed using apt."
  elif command -v pkg >/dev/null 2>&1; then
    pkg update && pkg install -y ruby && echo "Ruby installation successful." || echo "Ruby installation failed using pkg."
  else
    echo "No suitable package manager found for Ruby. Please install Ruby manually."
    exit 1
  fi
fi

echo "-----------------------------"

# --- Install cloudflared ---
if command -v cloudflared >/dev/null 2>&1; then
  echo "cloudflared is already installed. No need to install."
else
  echo "cloudflared not found. Installing..."

  if command -v apt >/dev/null 2>&1; then
    sudo apt update && sudo apt install -y cloudflared && echo "cloudflared installation successful." || echo "cloudflared installation failed using apt."
  elif command -v pkg >/dev/null 2>&1; then
    pkg update && pkg install -y cloudflared && echo "cloudflared installation successful." || echo "cloudflared installation failed using pkg."
  else
    echo "No suitable package manager found for cloudflared. Please install cloudflared manually."
    exit 1
  fi
fi

echo "-----------------------------"
echo "Installation script completed successfully."
