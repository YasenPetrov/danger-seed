#!/bin/bash

CURDIR=$PWD;
cd $PROJECT_ROOT;

echo "#!/bin/bash
cd ${SERVER_ROOT};
. venv/bin/activate;
./manage.py test;" > .git/hooks/pre-commit;
echo 'exit $?;' >> .git/hooks/pre-commit;
chmod +x .git/hooks/pre-commit;

echo "#!/bin/bash
cd ${PROJECT_ROOT};
git pull;
cd ${SERVER_ROOT};
. venv/bin/activate;
pip install -r requirements.txt;
./manage.py syncdb --noinput;
./manage.py migrate;" > .git/hooks/post-commit;
echo 'exit $?;' >> .git/hooks/post-commit;
chmod +x .git/hooks/post-commit;

cd $CURDIR;