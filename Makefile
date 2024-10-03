VERSION := 1.0
DOCKER_IMAGE := ineva/dns-sd-proxy
DOCKER_TARGET := $(DOCKER_IMAGE):$(VERSION)

all:: image push

image::
	docker build --platform linux/amd64 -t $(DOCKER_IMAGE):$(VERSION) .
	docker tag $(DOCKER_IMAGE):$(VERSION) $(DOCKER_IMAGE):latest

push::
	docker push $(DOCKER_IMAGE):$(VERSION)
	docker push $(DOCKER_IMAGE):latest
