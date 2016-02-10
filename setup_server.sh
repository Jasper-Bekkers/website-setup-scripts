#!/bin/bash
apt-get install nginx ruby vim git git-core nginx fcgiwrap apache2-utils
gem install jekyll

cp gitweb.conf /etc/gitweb.conf


echo "*****************************"
echo "run htpasswd -c /etc/nginx/.htpasswd <name>"
echo "*****************************"
