#!/bin/bash

if [ "$#" -ne 1 ]; then
	echo "Enter website name"
	exit 1
fi

WEBSITE_NAME=$1
sed -e s/example.com/$WEBSITE_NAME/g website_config.txt > /etc/nginx/sites-available/$WEBSITE_NAME

ln -s /etc/nginx/sites-available/$WEBSITE_NAME /etc/nginx/sites-enabled/
mkdir -p /var/www/html/$WEBSITE_NAME/public_html
touch /var/www/html/$WEBSITE_NAME/public_html/index.html

service nginx restart
