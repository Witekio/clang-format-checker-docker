TAG ?= latest
CMD ?= "-r ."

DOCKER_REGISTRY = index.docker.io
IMAGE_ORG = witekio
IMAGE_NAME = clang-format-checker
IMAGE_TAG = $(DOCKER_REGISTRY)/$(IMAGE_ORG)/$(IMAGE_NAME):$(TAG)

WORKING_DIR := $(shell pwd)
DOCKERFILE_DIR := $(WORKING_DIR)

.DEFAULT_GOAL := build

.PHONY: build push run

build:: ## Build the docker image
		@echo Building $(IMAGE_TAG)
		@docker build --pull \
			-t $(IMAGE_TAG) $(DOCKERFILE_DIR)

push:: ## Push the docker image to the registry
		@echo Pushing $(IMAGE_TAG)
		@docker push $(IMAGE_TAG)

run:: ## Run the docker image
		@docker run -v $(pwd):/src -it --rm $(IMAGE_TAG) $(CMD)

# A help target including self-documenting targets (see the awk statement)
define HELP_TEXT
Usage: make [TARGET]... [MAKEVAR1=SOMETHING]...

Available targets:
endef
export HELP_TEXT
help: ## This help target
	@echo
	@echo "$$HELP_TEXT"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / \
		{printf "\033[36m%-30s\033[0m  %s\n", $$1, $$2}' $(MAKEFILE_LIST)
