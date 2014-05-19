#!/bin/bash

CURDIR=$PWD;

# Set up Python Package Management
. $SCRIPTS/server/ppm.sh;

# Move to server to set up Django
cd $SERVER;

# Create the initial project structure
mkdir -p project;
django-admin.py startproject project .;

# Revert back to previous directory
cd $CURDIR;