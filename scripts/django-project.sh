#!/bin/bash

# Set up Python Package Management
. $SCRIPTS_ROOT/ppm.sh;

# Move to server to set up Django
cd $SERVER_ROOT;

# Create the DB schema
mkdir -p project;
django-admin.py startproject project .;

chmod +x manage.py;
./manage.py syncdb --noinput;


# Create a default user:password of admin:admin.
# Use to login to the Django admin site if enabled.
TIME=$(date +"%Y-%m-%d");
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

# Create a helper to avoid the cumbersome task of
# loading the virtual environment and changing
# directories before starting django.
cd ..;
echo "#!/bin/bash

function finish {
    deactivate;
}
trap finish EXIT;

DIR=\"\$( cd \"\$( dirname \"\${BASH_SOURCE[0]}\" )\" && pwd )\";
cd $DIR;

source ./venv/bin/activate;
cd src/;
./manage.py \"\$@\";" > .manage;
chmod +x .manage;