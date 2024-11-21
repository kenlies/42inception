# base image for alpine
FROM alpine:3.19

# install nginx & openssl
RUN apk update && \
	apk add --no-cache \
	nginx \
	openssl

# listen on default port for https
EXPOSE 443

# create dirs /run/nginx & /etc/nginx/ssl (to store SSL certificate)
RUN mkdir -p /run/nginx /etc/nginx/ssl

# generate SSL/TLS certificate and private key

# req -x509 		: generate a self-signed certificate 
# -nodes			: do not protect the private key with phassphrase
# -days 365			: key is valid for 365 days
# -newkey rsa:2048	: create a new RSA key with 2048 bits
# -out /path/		: store ssl certificate
# -keyout /path/	: store private key
# -subj				: details for certificate

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-out /etc/nginx/ssl/ssl_cert.crt \
	-keyout /etc/nginx/ssl/ssl_key.key \
	-subj "/C=FI/ST=UUSIMAA/L=HELSINKI/O=42/OU=Hive/CN=aotsala.42.fr"

# create a new user www-data without a home directory (-D -H),
# with a shell of /sbin/nologin (disabling login), and assigns it to the www-data group
# this is done due to security reasons (we do not want to run things as root user)
RUN adduser -D -H -s /sbin/nologin/ -g www-data -G www-data www-data

# copy nginx.conf file to the container
COPY conf/nginx.conf /etc/nginx/nginx.conf
RUN chmod 644 /etc/nginx/nginx.conf

# run nginx with conf file & set deamon off to run as foreground for docker
CMD ["nginx", "-c", "/etc/nginx/nginx.conf", "-g", "daemon off;"]
