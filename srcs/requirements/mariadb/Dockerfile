# base image for alpine
FROM alpine:3.19

# installing mariadb without caching package files, saving space
RUN apk update && \
	apk add --no-cache \
	mariadb \
	mariadb-client

# listen on default port for mariadb
EXPOSE 3306

# copy configure file to the base location for additional 
# config files for mariadb in alpine linux
COPY ./conf/configure.cnf /etc/my.cnf.d/configure.cnf
RUN chmod 644 /etc/my.cnf.d/configure.cnf

# copy setup file to /tmp so it can be trashed later
COPY ./tools/setup.sh /tmp/setup.sh
RUN chmod 700 /tmp/setup.sh

# run the setup script
CMD ["/tmp/setup.sh"]