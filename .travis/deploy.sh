#!/bin/bash

set -e
# git config --global push.default simple
# git remote add production ssh://debian@176.31.162.57/home/debian/webinterfaces/production
# git push production main

# ssh debian@176.31.162.57 -p 22 -v exit

# git pull

# docker-compose up -d --build
# docker ps
# pwd

# sudo apt install sshpass

sshpass -p 'yeM7Uz7G7FjZ' ssh debian@176.31.162.57 'cd /home/debian/webinterfaces;git pull;docker-compose down --volumes;docker-compose up -d --build;exit'
# pwd
# cd /home/webinterfaces
# git pull
# docker-compose up -d --build
# docker ps