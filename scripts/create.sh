#!/bin/bash

# Directory Variables for use with dependent scripts.
SCRIPTS="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )";
PROJECT="$SCRIPTS/..";
SERVER="$PROJECT/server";
CLIENT="$PROJECT/client";

. $SCRIPTS/vars.sh;

if [ $# -eq 0 ]
  then
    printf "No Creation Templates specified. Options are:\n"
    for f in `ls $SCRIPTS/_create/*.sh`
    do
      s=${f##*/}
      echo ${s%.*}
    done
    exit 1
fi

# Project Creation
for var in "$@"
do
  . $SCRIPTS/_create/$var.sh;
done

echo "$@" > $SCRIPTS/vars;
chmod +x $SCRIPTS/vars;