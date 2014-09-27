#!/bin/bash

mkdir -p $SERVICES/db;
cd $SERVICES/db;
SERVICES_DB=$SERVICES/db;


cp $SCRIPTS/_create/services/postgis $SERVICES_DB/Dockerfile;


echo -n "Please choose an ID for the project e.g. project-db: "
read projectid;

echo -n "Please choose a port to forward to the postgis service: "
read port;


# Docker DB Container creation script
echo '#!/bin/bash
SCRIPTS="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )";
cd $SCRIPTS;' > $SERVICES_DB/install.sh;

echo "# Create a docker image from the Dockerfile and tag it postgis v2.1
docker build -t postgis:2.1 .;
# Create container
docker run -d -p $port:5432 --name $projectid postgis:2.1;
docker stop $projectid;" >> $SERVICES_DB/install.sh;


# DB Start Script
echo '#!/bin/bash

SCRIPTS="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )";
cd $SCRIPTS;' > $SERVICES_DB/start.sh;

echo "docker start $projectid;" >> $SERVICES_DB/start.sh;


# DB Stop script
echo '#!/bin/bash

SCRIPTS="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )";
cd $SCRIPTS;' > $SERVICES_DB/stop.sh;

echo "docker stop $projectid;" >> $SERVICES_DB/stop.sh;


# DB Log script
echo '#!/bin/bash

SCRIPTS="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )";
cd $SCRIPTS;' > $SERVICES_DB/logs.sh

echo "docker logs -f --tail=\"all\" $projectid;" >> $SERVICES_DB/logs.sh;


# Allow files to be executable
chmod +x $SERVICES_DB/*.sh;


# Create setup script for postgis. Not a nice solution right now, config files needed.
echo '#!/bin/bash

cd $SERVICES/db;

./install.sh;
./start.sh;

mkdir -p $SERVER/project;' > $SCRIPTS/plugins/postgis.sh;
echo "
echo \"import subprocess


p = subprocess.Popen(['uname', '-s'], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
system = p.communicate()[0]


DOCKER_DB_HOST = 'localhost'
if system.strip().lower() == 'darwin':
  p = subprocess.Popen(['boot2docker', 'ip'], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
  DOCKER_DB_HOST = p.communicate()[0]


DOCKER_DB_PORT = $port

DATABASES = {
  'default': {
      'ENGINE': 'django.contrib.gis.db.backends.postgis',
      'NAME': 'docker',
      'USER': 'docker',
      'PASSWORD': 'docker',
      'HOST': DOCKER_DB_HOST,
      'PORT': DOCKER_DB_PORT,
  }
}\" > $SERVER/project/local_extra.py;

echo 'psycopg2' >> $SERVER/requirements.txt;

echo '

try:
    from project.local_extra import *
except ImportError:
    pass' >> $SERVER/project/settings.py" >> $SCRIPTS/plugins/postgis.sh