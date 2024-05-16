# Author -- meevs
# Creation Date -- 2023-11-02
# File Name -- Dockerfile
# Notes --

FROM alpine:latest AS fabric_mc

ARG JAVA_VERSION="17"
ARG MC_VERSION="1.20.2"
ARG MC_EULA="false"
ARG FABRIC_LOADER_VERSION="0.14.24"
ARG FABRIC_INSTALLER_VERSION="0.11.2"
ARG INSTALL_DIR="/home/fabric/server/"
ARG SERVER_CONFIG="server.properties"
ARG MIN_RAM="2G"
ARG MAX_RAM="4G"

ENV JAVA_VERSION="${JAVA_VERSION}"
ENV MC_VERSION="${MC_VERSION}"
ENV MC_EULA="${MC_EULA}"
ENV FABRIC_LOADER_VERSION="${FABRIC_LOADER_VERSION}"
ENV FABRIC_INSTALLER_VERSION="${FABRIC_INSTALLER_VERSION}"
ENV INSTALL_DIR="${INSTALL_DIR}"
ENV MIN_RAM="${MIN_RAM}"
ENV MAX_RAM="${MAX_RAM}"

# Install curl, java, and any other potential dependencies
RUN apk add --no-cache curl "openjdk${JAVA_VERSION}-jre" bash \
	&& mkdir --parent "${INSTALL_DIR}"

# Install fabric server
# Setup 
WORKDIR /tmp/fabric/
RUN curl -OJ curl -OJ "https://meta.fabricmc.net/v2/versions/loader/${MC_VERSION}/${FABRIC_LOADER_VERSION}/${FABRIC_INSTALLER_VERSION}/server/jar"

# Copy container files in
COPY "./config_files/${SERVER_CONFIG}" "${INSTALL_DIR}/server.properties"
COPY ./container_scripts/init_container.sh /usr/bin/init_container.sh
COPY ./container_scripts/start_server.sh /tmp/fabric/start_server.sh

RUN chmod a+x "/usr/bin/init_container.sh" "/tmp/fabric/start_server.sh"

WORKDIR "${INSTALL_DIR}"

CMD [ "/bin/bash", "-c" ]
ENTRYPOINT [ "init_container.sh" ]
