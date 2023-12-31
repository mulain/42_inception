NAME		=	inception
DC-FILE		=	srcs/docker-compose.yml

COLOR	= \033[30m
RESET	= \033[0m

ifeq ($(shell uname), Linux)
	HOMEPATH=/home/${USER}/data
else
	HOMEPATH=/Users/${USER}/data
endif

export HOMEPATH

all: makedirs
	docker-compose -f $(DC-FILE) up -d

build: down makedirs
	docker-compose -f $(DC-FILE) up -d --build

attached:
	docker-compose -f $(DC-FILE) up --build

down:
	docker-compose -f $(DC-FILE) down

# also deletes the volumes (along with their data)
down-v:
	docker-compose -f $(DC-FILE) down -v

makedirs:
	mkdir -p ~/data/mariadb
	mkdir -p ~/data/wordpress

# stops all docker containers, not only the ones from the current compose file
# not really necessary here, since we are in a machine with only this project.
# But useful to stop potential other containers from older builds with other names etc.
stopall:
	@CONTAINERS=$$(docker ps -qa); \
	if [ -n "$$CONTAINERS" ]; then \
		echo "Stopping all running containers:"; \
		docker stop $$CONTAINERS; \
	fi

# this will fail if volumes are still in use (that includes shutdown containers with bind volumes)
# it is just to clean up orphan volumes with other names from previous builds
rmvolumes:
	@VOLUMES=$$(docker volume ls --format '{{.Name}}'); \
	if [ -n "$$VOLUMES" ]; then \
		echo "Removing all volumes:"; \
		docker volume rm -f $$VOLUMES; \
	fi

rmdirs:
	sudo rm -rf ~/data/mariadb/*
	sudo rm -rf ~/data/wordpress/*

re: down-v rmdirs build

# this rule is only ok because we are in a virtual machine that only contains this project
nuke: down-v rmdirs
	docker system prune --all --force

git:
	git add .
	git commit -m "auto add & push"
	git push
	@echo "$(COLOR)git auto add & push performed.$(RESET)"

mgit:
	git add .
	@read -p "Enter the commit message: " msg; \
	git commit -m "$$msg"
	git push
	@echo "$(COLOR)git auto add & push with message performed.$(RESET)"
