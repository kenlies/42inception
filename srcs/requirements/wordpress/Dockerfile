# base image for alpine
FROM alpine:3.19

# 1. create a system group
# 2. create a system user, add to nginx group, set GECOS to nginx
RUN addgroup -S nginx && \
	adduser -S -G nginx -g nginx nginx

# install necessary packages
RUN apk update && \
	apk add --no-cache \
	php83 \
	php83-fpm \
	php83-cgi \
	php83-phar \
	php83-json \
	php83-mysqli \
	php83-curl \
	php83-iconv \
	wget \
	composer \
	bash \
	mariadb-client

RUN rm /usr/bin/php

RUN ln -s /usr/bin/php83 /usr/bin/php

# PHP-FPM listens for incoming FastCGI request on port 9000
EXPOSE 9000

# create /run/php/ for runtime data
# create /var/www/html/wordpress/ for standard Wordpress installation
RUN mkdir -p /run/php/ /var/www/html/wordpress/

# copy PHP-FPM config file to the right location
COPY conf/www.conf /etc/php83/php-fpm.d/www.conf
RUN chmod 644 /etc/php83/php-fpm.d/www.conf

# copy wordpress config file to root of container
COPY ./tools/setup.sh /
RUN chmod 700 setup.sh

CMD ["sh", "/setup.sh"]


