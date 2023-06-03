# Container image that runs your code
FROM alpine:3.16

# Install ghostscript
RUN apk --no-cache add ghostscript git git-lfs

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]