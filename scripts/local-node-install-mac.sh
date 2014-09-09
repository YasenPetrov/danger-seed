#!/bin/bash
# Use this command if you are on a shared computer, or
# if for some reason you are unable to install packages
# on npm globally (npm install -g lib_name).
#
# This switches npm to point to a folder that is within
# your home directory and therefore accessible.

mkdir -p npm ~/.local/share/npm;
npm config set prefix ~/.local/share/npm;
echo 'export PATH=$HOME/.local/share/npm/bin:$PATH' >> ~/.bash_profile;
. ~/.bash_profile;
