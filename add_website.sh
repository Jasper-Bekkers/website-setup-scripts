#!/bin/bash

if [ "$#" -ne 1 ]; then
	echo "Enter website name"
	exit 1
fi

WEBSITE_NAME=$1

# set up website, this sets up the domain, a git. subdomain & gitweb. subdomain
sed -e s/example.com/$WEBSITE_NAME/g website_config.txt > /etc/nginx/sites-available/$WEBSITE_NAME

# set up the stuff nginx needs
ln -s /etc/nginx/sites-available/$WEBSITE_NAME /etc/nginx/sites-enabled/
mkdir -p /var/www/html/$WEBSITE_NAME/public_html
mkdir -p /var/www/html/$WEBSITE_NAME/conf
touch /var/www/html/$WEBSITE_NAME/public_html/index.html

# we need a custom config for gitweb to show only the domain
sed -e s/example.com/$WEBSITE_NAME/g gitweb.conf > /var/www/html/$WEBSITE_NAME/conf/gitweb.conf


# set up empty git repo, with a post commit hook to rebuild jekyll
git init --bare /srv/git/$WEBSITE_NAME/$WEBSITE_NAME.git
sed -e s/example.com/$WEBSITE_NAME/g post-receive > /srv/git/$WEBSITE_NAME/$WEBSITE_NAME.git/hooks/post-receive
chmod +x /srv/git/$WEBSITE_NAME/$WEBSITE_NAME.git/hooks/post-receive
chown -R www-data /srv/git/$WEBSITE_NAME/$WEBSITE_NAME.git
chown -R www-data /var/www/html/$WEBSITE_NAME/public_html

service nginx restart
