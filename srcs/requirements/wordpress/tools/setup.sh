#!/bin/bash

attempts=0
# attempt a successful connection to mariadb, redirect output to void
while ! mariadb -h $MYSQL_HOST -u $WP_DB_USER -p$WP_DB_PASSWORD $WP_DB_NAME &>/dev/null; do
	attempts=$((attempts + 1))
	echo "MariaDB unavailable. Attempt $attempts / 12: Trying again in 5 sec."
	if [ $attempts -ge 12 ]; then
		echo "Max attempts reached. MariaDB connection could not be established."
	exit 1
	fi
	sleep 5
done
echo "MariaDB connection established!"
echo "Listing databases:"

# connect to database and show tables
mariadb -h$MYSQL_HOST -u$WP_DB_USER -p$WP_DB_PASSWORD $WP_DB_NAME <<EOF
SHOW DATABASES;
EOF

# change to wordpress installation folder
cd /var/www/html/wordpress

# download the WP-CLI, save to /usr/local/bin/wp
wget -q https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -O /usr/local/bin/wp
chmod +x /usr/local/bin/wp

# use WP-CLI to download the core WordPress files
wp core download --allow-root

echo "before creating config"

# use WP-CLI to create wp-config.php file with the specified database connection details
wp config create \
	--dbname=$WP_DB_NAME \
	--dbuser=$WP_DB_USER \
	--dbpass=$WP_DB_PASSWORD \
	--dbhost=$MYSQL_HOST \
	--path=/var/www/html/wordpress/ \
	--force \
	--allow-root;

echo "after creating config"

# use WP-CLI to install WordPress with the specified settings
# --skip-email flag prevents sending a confirmation email
wp core install \
	--url=$DOMAIN_NAME \
	--title=$WP_TITLE \
	--admin_user=$WP_ADMIN_USER \
	--admin_password=$WP_ADMIN_PASSWORD \
	--admin_email=$WP_ADMIN_EMAIL \
	--skip-email \
	--path=/var/www/html/wordpress/ \
	--allow-root;

# use WP-CLI to create a suser as the author
wp user create \
	$WP_USER \
	$WP_EMAIL \
	--role=author \
	--user_pass=$WP_PASSWORD \
	--path=/var/www/html/wordpress/ \
	--allow-root;

# use WP-CLI to install & activate neve theme 
wp theme install neve \
	--activate \
	--allow-root;

# use WP-CLI to update all plugins
wp plugin update --all

# use WP-CLI to update the siteurl and home options in the WordPress database
wp option update siteurl "https://${DOMAIN_NAME}" --allow-root
wp option update home "https://${DOMAIN_NAME}" --allow-root

# change ownership of all files and dirs in /var/www/html/wordpress to nginx user and group
chown -R nginx:nginx /var/www/html/wordpress
chmod -R 755 /var/www/html/wordpress

# start PHP-FPM service in the foreground 
# -F to ensure that PHP-FPM runs as the main process of the container

echo "run php-fpm"

php-fpm83 -F