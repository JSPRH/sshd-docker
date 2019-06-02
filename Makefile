# Makefile
PROJECT="docker-alpine-sshd"

## Show help
help:
	@echo ''
	@echo 'SSH Hop 🚀'
	@echo ''
	@echo 'Usage:'
	@echo '  make <target>'
	@echo ''
	@echo 'Targets:'
	@awk '/^[a-zA-Z\-\_0-9]+:/ { \
		helpMessage = match(lastLine, /^## (.*)/); \
		if (helpMessage) { \
			helpCommand = substr($$1, 0, index($$1, ":")-1); \
			helpMessage = substr(lastLine, RSTART + 3, RLENGTH); \
			printf "  %-$(TARGET_MAX_CHAR_NUM)s %s\n", helpCommand, helpMessage; \
		} \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST)

## Generate all keys
generate-keys:
	echo "Generating root rsa key pair"
	ssh-keygen -f docker/keys/root/id_rsa -N '' -t rsa -C ${PROJECT} -b 4096
	echo "Generating host rsa key pair"
	ssh-keygen -f docker/keys/host/ssh_host_rsa_key -N '' -t rsa -C ${PROJECT} -b 4096
	#echo "Generating host dsa key pair"
	#ssh-keygen -f docker/keys/host/ssh_host_dsa_key -N '' -t dsa -C ${PROJECT}
	echo "Generating host ecdsa key pair"
	ssh-keygen -f docker/keys/host/ssh_host_ecdsa_key -N '' -t ecdsa -C ${PROJECT}
	echo "Generating host ecdsa key pair"
	ssh-keygen -f docker/keys/host/ssh_host_ed25519_key -N '' -t ed25519 -C ${PROJECT}

## Setup and start infrastructure
up:
	docker-compose up -d

## Stop and remove infrastructure
down:
	docker-compose down

## Build all files which definition has changed
build:
	docker-compose build

## Watch the service composition
watch:
	watch docker-compose ps

## Watch the service logs
logs:
	docker-compose logs -ft

.PHONY: up down