S3CMD_VERSION	= $(shell cat VERSION)
IMAGE_VERSION	= $(S3CMD_VERSION)-$(shell git describe --always --tags)

default: Dockerfile
	docker build -t infoblox/s3cmd:$(IMAGE_VERSION) \
		--build-arg AWS_REGION=$(AWS_REGION) \
		--build-arg AWS_ACCESS_KEY_ID=$(AWS_ACCESS_KEY_ID) \
		--build-arg AWS_SECRET_ACCESS_KEY=$(AWS_SECRET_ACCESS_KEY) \
		.
	docker push infoblox/s3cmd:$(IMAGE_VERSION)

Dockerfile: Dockerfile.in VERSION
	sed "s/VERSION/$(S3CMD_VERSION)/g" Dockerfile.in > .Dockerfile
	mv .Dockerfile Dockerfile

clean:
	rm -f Dockerfile .Dockerfile

