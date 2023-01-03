.EXPORT_ALL_VARIABLES:
VERSION=edge

DOCKER_REGISTRY=localhost
DOCKER_IMAGE_NAME=frontend-app

BUILDX_PLATFORM=linux/amd64
DOCKER_IMAGE_TAG=${DOCKER_REGISTRY}/${DOCKER_IMAGE_NAME}:${VERSION}

# Docker Metadata Actions
DOCKER_META_IMAGES=${DOCKER_REGISTRY}/${DOCKER_IMAGE_NAME}
DOCKER_META_VERSION=${VERSION}

main:
	@echo No action was performed.
	@echo
	@echo Available flags:
	@echo - VERSION=${VERSION}
	@echo - DOCKER_REGISTRY=${DOCKER_REGISTRY}
	@echo - DOCKER_IMAGE_NAME=${DOCKER_IMAGE_NAME}
	@echo - BUILDX_PLATFORM=${BUILDX_PLATFORM}
	@echo
	@echo Read-only flags:
	@echo - DOCKER_IMAGE_TAG=${DOCKER_IMAGE_TAG}
	@echo - DOCKER_META_IMAGES=${DOCKER_META_IMAGES}
	@echo - DOCKER_META_VERSION=${DOCKER_META_VERSION}
	@echo
	@echo Available commands:
	@echo - run: run docker container
	@echo - push: push docker image to registry
	@echo - build: build docker image
	@echo - bash: run with interactive console

build:
	@docker buildx bake \
		--file Makefile.docker-bake.hcl \
		--print build
	@echo Building ${DOCKER_IMAGE_TAG} docker image
	@docker buildx bake \
			--file Makefile.docker-bake.hcl \
			--load build

push:
	@echo Pushing ${DOCKER_IMAGE_TAG} to registry
	@docker push ${DOCKER_IMAGE_TAG}

run:
	@echo Running ${DOCKER_IMAGE_TAG} image on port http://localhost:8088
	@docker run -it --rm \
		--publish 8088:80 \
		${DOCKER_IMAGE_TAG}

bash:
	@echo Running ${DOCKER_IMAGE_TAG} image on port http://localhost:8088
	@docker run -it --rm \
		--env SATELLITE_CONFIG_PATH=/satellite.hcl \
		--publish 8088:80 \
		${DOCKER_IMAGE_TAG} \
		/bin/sh
