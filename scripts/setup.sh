#!/bin/bash

# Environmental variables to highlight the status of our code.
BOLD=$(tput bold);
ERROR=${BOLD}$(tput setaf 1);
WARNING=${BOLD}$(tput setaf 3);
INFO=${BOLD}$(tput setaf 2);
RESET=$(tput sgr0);

# Directory Variables for use with dependent scripts.
SCRIPTS_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )";
PROJECT_ROOT="$SCRIPTS_ROOT/..";
SERVER_ROOT="$PROJECT_ROOT/server";
CLIENT_ROOT="$PROJECT_ROOT/client";

# Move into scripts directory to run scripts.
cd $SCRIPTS_ROOT;

# Custom sequence of installation scripts depending on
# technologies used.
. ppm.sh;