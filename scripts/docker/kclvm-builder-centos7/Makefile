# Copyright 2021 The KCL Authors. All rights reserved.

PWD:=$(shell pwd)
TIMESTAMP:=$(shell go run timestamp.go)

BUILDER_IMAGE:=kusionstack/kclvm-builder:centos7

# export DOCKER_DEFAULT_PLATFORM=linux/amd64
# or
# --platform linux/amd64

RUN_IN_DOCKER:=docker run -it --rm --platform linux/amd64
RUN_IN_DOCKER+=-v ~/.ssh:/root/.ssh
RUN_IN_DOCKER+=-v ~/.gitconfig:/root/.gitconfig
RUN_IN_DOCKER+=-v ~/go/pkg/mod:/go/pkg/mod

kclvm-builder:
	docker build --platform linux/amd64 -t ${BUILDER_IMAGE} .
	@echo "ok"

publish-builder:
	# https://docker.inc.com/
	# docker login --username=

	# make kclvm-builder
	docker push ${BUILDER_IMAGE}
	@echo "push ${BUILDER_IMAGE} ok"

sh:
	${RUN_IN_DOCKER} -v ${PWD}/../../..:/root/kclvm -w /root ${BUILDER_IMAGE} bash

clean:
