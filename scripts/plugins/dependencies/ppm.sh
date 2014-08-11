#!/bin/bash
# This script is concerned with Python Package Management
# For use with Django/Flask and any other python frameworks.
# All project dependencies will be stored in PROJECT_ROOT/venv

# Check required python tools are installed and accessible as current user
command -v python >/dev/null 2>&1;
if [ $? != 0 ]; then
    echo "${ERROR}ERROR: python not found. Please install specific to your OS.${RESET}" >&2;
    exit 1;
fi;

command -v easy_install >/dev/null 2>&1;
if [ $? != 0 ]; then
    echo "${ERROR}ERROR: easy_install not found. Please install specific to your OS.${RESET}" >&2;
    exit 1;
fi;

command -v virtualenv >/dev/null 2>&1;
if [ $? != 0 ]; then
    echo "${WARNING}WARNING: virtualenv not found.${RESET}" >&2;
    echo "${INFO}INFO: Attempting to install virtualenv.${RESET}";
    sudo easy_install virtualenv;
    if [ $? != 0 ]; then
        printf "${ERROR}ERROR: There was an problem installing virtualenv.\nCheck network and contact an Administrator.${RESET}\n" >&2;
        exit 1;
    fi
fi;
