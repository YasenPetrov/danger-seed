#!/bin/bash

# Directory Variables for use with dependent scripts.
SCRIPTS="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )";
PROJECT="$SCRIPTS/..";
SERVER="$PROJECT/server";
CLIENT="$PROJECT/client";

. $SCRIPTS/vars.sh;

# Reset git hooks
echo "#!/bin/bash" > $PROJECT/.git/hooks/pre-commit;
echo "#!/bin/bash" > $PROJECT/.git/hooks/post-commit;

# Setup
for var in "$@"
do
  . $SCRIPTS/plugins/$var.sh;
done

# Make git hooks executable
chmod +x $PROJECT/.git/hooks/pre-commit $PROJECT/.git/hooks/post-commit;

# Finally make sure all pulls and pushes go to master
cd $PROJECT;
git branch --set-upstream-to=origin/master master;
