#!/bin/bash

# Set up Python Package Management
. $SCRIPTS_ROOT/ppm.sh;

# Move to server to set up Django
cd $SERVER_ROOT;

# Create the initial project structure
mkdir -p project;
django-admin.py startproject project .;