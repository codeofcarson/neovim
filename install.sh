#!/bin/bash
set -euf -o pipefail

# Change into the directory the script is located in to make things easier
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$SCRIPT_DIR"

# Download all the required submodules for the plugins.
git submodule update --init --recursive

# Create symbolic links to the nvim configuration folders.
ln -s "$SCRIPT_DIR/config" "${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
ln -s "$SCRIPT_DIR/share"  "${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site"
