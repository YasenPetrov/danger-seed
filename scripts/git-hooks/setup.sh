#!/bin/bash

cd $PROJECT;

echo "#!/bin/bash" > .git/hooks/pre-commit;
echo "#!/bin/bash" > .git/hooks/post-commit;

for var in "$@"
do
  . $SCRIPTS/git-hooks/$var.sh;
done

chmod +x .git/hooks/pre-commit .git/hooks/post-commit;
