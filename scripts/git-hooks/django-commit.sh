#!/bin/bash

CURDIR=$PWD;
cd $PROJECT_ROOT;

echo "#!/bin/bash

cd ${SERVER_ROOT};
. venv/bin/activate;
./manage.py test;" > .git/hooks/pre-commit;
echo 'exit $?' >> .git/hooks/pre-commit;
chmod +x .git/hooks/pre-commit;


#echo '#!/bin/bash
#
#
#PLEASE NOW RUN:
#
#./bin/buildout; (if buildout.cfg has changed)
#./bin/django syncdb;
#./bin/django migrate;
#
#THIS WILL INSTALL OTHER DEVELOPERS 3RD PARTY DEPENDENCIES AND DATABASE CHANGES.
#==========================="' > .git/hooks/post-merge
#chmod 755 .git/hooks/pre-commit .git/hooks/post-merge

cd $CURDIR;