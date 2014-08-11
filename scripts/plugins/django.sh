#!/bin/bash

# Set up Python Package Management
. $SCRIPTS/plugins/dependencies/ppm.sh;
. $SCRIPTS/plugins/virtualenv-pip.sh;

# Make sure we are in the server root
cd $SERVER;

# Create the DB schema.
chmod +x manage.py;
./manage.py migrate;

# Create a default user:password of admin:admin.
# Use to login to the Django admin site if enabled.
TIME=$(date +"%Y-%m-%d %H:%M:%S%z");
echo "[
      {
        \"pk\": 1,
        \"model\": \"auth.user\",
        \"fields\": {
            \"username\": \"admin\",
            \"first_name\": \"\",
            \"last_name\": \"\",
            \"is_active\": true,
            \"is_superuser\": true,
            \"is_staff\": true,
            \"last_login\": \"$TIME\",
            \"groups\": [],
            \"user_permissions\": [],
            \"password\": \"sha1\$4fb62\$008ea7e3d84e68a5b74601abf679820fefe5664f\",
            \"email\": \"\",
            \"date_joined\": \"$TIME\"
        }
    }
]" > auth.json;
./manage.py loaddata auth.json;
rm auth.json;


# Create git hooks for django
echo "
# Django
cd ${SERVER};
. venv/bin/activate;
./manage.py test;" >> $PROJECT/.git/hooks/pre-commit;
echo '
if [ $? != 0 ]; then
    exit 1;
fi' >> $PROJECT/.git/hooks/pre-commit;

echo "
# Django
cd ${PROJECT};
git pull origin master;
cd ${SERVER};
. venv/bin/activate;" >> $PROJECT/.git/hooks/post-commit;

echo 'var="`pip install -r requirements.txt --no-index --find-links=file://$HOME/.pip_packages`";
if [ $? -eq 0 ]; then
    echo "INFO: All requirements are satisfied. No need to download from Package Index.";
    printf "$var\n";
else
    echo "INFO: Requirements not found locally or error occured.";
    printf "$var\n";
    pip install --download-cache $HOME/.pip_packages -r requirements.txt;
fi
./manage.py migrate;' >> $PROJECT/.git/hooks/post-commit;
