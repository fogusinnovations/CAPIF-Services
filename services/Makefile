SHELL := /bin/bash
export VERSION ?= 1.0
DOCKER_COMPOSE := docker compose -p fogus_capif

default: run
restart: stop run
fresh: clean run

stop:
	@ $(DOCKER_COMPOSE) stop && \
	echo -e  "\e[32m*** All Capif services are stopped ***\e[0m" || \
	echo -e  "\e[31m*** Some Capif services failed to be stopped ***\e[0m"

down:
	@ $(DOCKER_COMPOSE) down --rmi local --remove-orphans &&\
	echo -e  "\e[32m*** All Capif services are removed ***\e[0m" || \
	echo -e  "\e[31m*** Some Capif services failed to be removed ***\e[0m"

run:
	@ [ -z $(HOSTNAME) ] && CAPIF_HOSTNAME=capifcore || CAPIF_HOSTNAME=$(HOSTNAME); \
	echo -e "\e[35mNginx hostname will be $$CAPIF_HOSTNAME\e[0m"; \
	CAPIF_HOSTNAME=$$CAPIF_HOSTNAME $(DOCKER_COMPOSE) up -d && \
	echo -e "\e[35m*** All Capif services are running ***\e[0m" || \
	echo -e "\e[31m*** Some Capif services failed to start ***\e[0m"

check:
	@ $(DOCKER_COMPOSE) ps --services --filter "status=running" | sort > running
	@ $(DOCKER_COMPOSE) ps --services -a | sort > services
	@ diff services running > /dev/null 2>&1 && echo -e "\e[35mAll services are running\e[0m" || \
	echo -e "\e[31mFollowing services are not running:\e[0m" && diff services running | grep "<" | cut -d " " -f2; \
	rm services running
# ifeq ($(diff services running | wc -l), 15)
# 	echo "\e[31mAll services are down\e[0m"
# else
# 	echo "\e[31mFollowing services are not running:\e[0m" && diff services running | cut -d " " -f2
# endif
#[ "$((diff services running | grep "<" | wc -l))" = "15" ] && echo -e "\e[31mAll services are down\e[0m" || \ #


# Prepare argument list for 'run' target
ifeq (run,$(firstword $(MAKECMDGOALS)))
  HOSTNAME := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  $(eval $(HOSTNAME):;@:)
endif

.PHONY: default restart fresh stop down run check
