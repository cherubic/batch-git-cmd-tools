COMMIT_ID:=$(shell git rev-parse --short=8 HEAD)

build:
	docker build --network=host -t batch-git-tools:${COMMIT_ID} .

push:
	docker push batch-git-tools:${COMMIT_ID}