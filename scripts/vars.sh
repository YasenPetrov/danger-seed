#!/bin/bash

# Environmental variables to highlight the status of our code.
BOLD=$(tput bold);
ERROR=${BOLD}$(tput setaf 1);
WARNING=${BOLD}$(tput setaf 3);
INFO=${BOLD}$(tput setaf 2);
RESET=$(tput sgr0);

# Directory Variables for use with dependent scripts.
SCRIPTS="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )";
PROJECT="$SCRIPTS/..";
SERVER="$PROJECT/server";
CLIENT="$PROJECT/client";
