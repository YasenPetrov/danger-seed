#!/bin/bash

# Directory Variables for use with dependent scripts.
SCRIPTS="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )";
PROJECT="$SCRIPTS/..";
SERVER="$PROJECT/server";
CLIENT="$PROJECT/client";

. $SCRIPTS/vars.sh;

# Project Creation
for var in "$@"
do
  . $SCRIPTS/_create/$var.sh;
done
