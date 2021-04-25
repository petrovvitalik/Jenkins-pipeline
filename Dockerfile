FROM maven:alpine

# Install pacakges
RUN apk update && apk add openssh-client docker

# Configure ssh client
COPY id_rsa /root/.ssh/id_rsa
RUN chmod 600 /root/.ssh/id_rsa