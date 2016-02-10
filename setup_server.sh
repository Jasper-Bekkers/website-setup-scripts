#!/bin/bash
apt-get install nginx ruby ruby-dev vim git git-core nginx fcgiwrap apache2-utils gcc make
gem install jekyll

echo "*****************************"
echo "run htpasswd -c /etc/nginx/.htpasswd <name>"
echo "*****************************"
