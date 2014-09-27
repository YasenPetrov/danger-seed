#!/bin/bash

# Make sure we have node installed
. $SCRIPTS/plugins/dependencies/node.sh;

# As angular generator requires SASS/Compass check that too
. $SCRIPTS/plugins/dependencies/sass.sh;

cd $CLIENT;

# Global dependencies
npm install -g grunt grunt-cli bower;

# Local dependencies
npm install;
bower install;
npm install karma-jasmine --save-dev;
npm install karma-chrome-launcher --save-dev;

# Add Yeoman Angular generator hooks for pre/post commit
cd $PROJECT;
echo "
# Yeoman Angular Grunt
cd ${CLIENT};
grunt test;" >> .git/hooks/pre-commit;
echo '
if [ $? != 0 ]; then
    exit 1;
fi' >> $PROJECT/.git/hooks/pre-commit;
echo "
# Yeoman Angular Grunt
cd ${PROJECT};
git pull origin master;
cd ${CLIENT};
npm install;
bower install;" >> $PROJECT/.git/hooks/post-commit;
