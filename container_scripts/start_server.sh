#! /bin/bash
# Author -- meevs
# Creation Date -- 2023-11-03
# Notes --

java -Xms"${MIN_RAM}" -Xmx"${MAX_RAM}" -jar "fabric-server-mc.${MC_VERSION}-loader.${FABRIC_LOADER_VERSION}-launcher.${FABRIC_INSTALLER_VERSION}.jar" nogui
