#!/bin/bash

# Set up Python Package Management
. $SCRIPTS/server/ppm.sh;

# Move to server to set up Django
cd $SERVER;

# Create the initial project structure
mkdir -p project;
django-admin.py startproject project .;

echo "
venv
*.pyc
*.pyo
*.sqlite3
" > .gitignore
