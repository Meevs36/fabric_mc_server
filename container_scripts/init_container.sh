#! /bin/bash
# Author -- meevs
# Creation Date -- 2023-11-03
# File Name -- init_container.sh
# Notes --

# Check if initial setup has been done
if [[ ! -f ./fabric-server-mc.${MC_VERSION}-loader.${FABRIC_LOADER_VERSION}-launcher.${FABRIC_INSTALLER_VERSION}.jar ]]
then
	echo "Initializing server"
	cp --recursive /tmp/fabric/* ./
fi

if [[ ! -f ./eula.txt ]]
then
	echo -e "Writing EULA..."
	echo -e "Currently at ${PWD}"
	touch ./eula.txt
	echo "eula=${MC_EULA}" > ./eula.txt
fi

echo -e "\e[32;2;0;200;0mStarting server...\e[0m"
./start_server.sh
