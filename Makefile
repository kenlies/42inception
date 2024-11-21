include srcs/.env
export $(sed 's/=.*//' srcs/.env)

all:
	@if ! sudo grep -q "127.0.0.1 ${DOMAIN_NAME}" /etc/hosts; then \
		echo "127.0.0.1 ${DOMAIN_NAME}" | sudo tee -a /etc/hosts; \
	fi
	mkdir -p /Users/alexndr/tmp/mariadb_data
	mkdir -p /Users/alexndr/tmp/wordpress_data
	docker compose -f srcs/docker-compose.yml build
	docker compose -f srcs/docker-compose.yml up -d
clean:
	docker compose -f srcs/docker-compose.yml down --rmi all -v

fclean:	clean
	rm -rf /Users/alexndr/tmp/mariadb_data
	rm -rf /Users/alexndr/tmp/wordpress_data
	docker system prune -f

re:	fclean all

up:
	docker compose -f srcs/docker-compose.yml up -d
down:
	docker compose -f srcs/docker-compose.yml down
.phony:  all clean fclean re up down
