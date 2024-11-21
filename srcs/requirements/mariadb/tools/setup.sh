#!/bin/sh

# create dir for run time files if not already exist
mkdir -p /run/mysqld
# change ownerships
chown -R mysql:mysql /run/mysqld
chown -R mysql:mysql /var/lib/mysql
chmod -R 777 /var/lib/mysql
# initialize mysql data directory
mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql --rpm > /dev/null
# initialize mysql in bootstrap mode for setup
mysqld --user=mysql --bootstrap << EOF

USE mysql;
FLUSH PRIVILEGES;

DELETE FROM mysql.user WHERE User='';
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');

ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
CREATE DATABASE ${WP_DB_NAME} CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER '${WP_DB_USER}'@'%' IDENTIFIED by '${WP_DB_PASSWORD}';
GRANT ALL PRIVILEGES ON *.* TO '${WP_DB_USER}'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EOF

# start mysql server with a configuration file
exec mysqld_safe --defaults-file=/etc/my.cnf.d/configure.cnf
