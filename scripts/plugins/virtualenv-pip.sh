#!/bin/bash
# This script is concerned with Python Package Management
# For use with Django/Flask and any other python frameworks.
# All project dependencies will be stored in PROJECT_ROOT/venv

# Move into server folder to install required libraries.
cd $SERVER;

# Create a virtual environment where all python dependencies
# specific to this project will live. Allows for projects
# to have differing versions of external libraries without
# causing conflicts.
virtualenv venv;
. venv/bin/activate;
mkdir -p $HOME/.pip_packages;

# Install project requirements
var="`pip install -r requirements.txt --no-index --find-links=file://$HOME/.pip_packages`";
if [ $? -eq 0 ]; then
    echo "INFO: All requirements are satisfied. No need to download from Package Index.";
    printf "$var\n";
else
    echo "INFO: Requirements not found locally or error occured.";
    printf "$var\n";
    pip install --download-cache $HOME/.pip_packages -r requirements.txt;
fi
