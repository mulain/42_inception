NAME		=	inception
DC-FILE		=	srcs/docker-compose.yml

all: makedirs
	docker-compose -f $(DC-FILE) up -d

build: makedirs
	docker-compose -f $(DC-FILE) up -d --build

attached:
	docker-compose -f $(DC-FILE) up --build

down:
	docker-compose -f $(DC-FILE) down

makedirs:
	mkdir -p ~/data/mariadb
	mkdir -p ~/data/wordpress

clean:
	docker-compose -f $(DC-FILE) down --volumes --remove-orphans

fclean: clean
	docker-compose -f $(DC-FILE) down --rmi all --volumes --remove-orphans
	sudo rm -rf ~/data/mariadb/*
	sudo rm -rf ~/data/wordpress/*

re: clean all
