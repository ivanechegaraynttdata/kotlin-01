PROJECT = mobile
SERVICE = kotlin
ENV     = lab

base:
	export DOCKER_BUILDKIT=0 && \
	  docker build -t ${PROJECT}-${PROJECT}-${PROJECT}:latest .