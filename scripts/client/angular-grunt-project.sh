#!/bin/bash

# Make sure we have node installed
. $SCRIPTS/client/dependency/node.sh;

# As angular generator requires SASS/Compass check that too
. $SCRIPTS/client/dependency/sass.sh;

cd $CLIENT;

npm install -g yo generator-angular;
yo angular;