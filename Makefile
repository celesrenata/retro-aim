# Docker - Build
docker-build:
	docker build --pull -t ghcr.io/celesrenata/retro-aim:latest \
		-f docker/Dockerfile .

docker-push:
	docker push ghcr.io/celesrenata/retro-aim:latest
