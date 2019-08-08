#!/bin/bash

BASE_URL='https://www.minecraft.net/en-us/download/server/bedrock/'
SERVER=${MCFolder}/server
DOWNLOAD=${MCFolder}/download
BACKUP=${MCFolder}/backup

#checks if folders exist
    if [ -d ${DOWNLOAD} ] ; then
        printf  "${DOWNLOAD} already exists."
        else
        mkdir -p ${DOWNLOAD}
        printf  "${DOWNLOAD} created."
    fi
    if [ -d ${SERVER} ] ; then
        printf  "${SERVER} already exists."
        else
        mkdir -p ${SERVER}
        printf  "${SERVER} created."
    fi
    if [ -d ${BACKUP} ] ; then
        printf  "${BACKUP} already exists."
        else
        mkdir -p ${BACKUP}
        printf  "${BACKUP} created."
    fi
printf "\n"
# checks if latests ver downloaded
URL=`curl -L ${BASE_URL} 2>/dev/null| grep bin-linux | sed -e 's/.*<a href=\"\(https:.*\/bin-linux\/.*\.zip\).*/\1/'`
if [ ! -e ${DOWNLOAD}/${URL##*/} ] ; then
  #creates backup before update
  cp ${SERVER}/server.properties ${BACKUP}/server.properties.bak
  cp ${SERVER}/permissions.json ${BACKUP}/permissions.json.bak
  cp ${SERVER}/whitelist.json ${BACKUP}/whitelist.json.bak
  printf "Backup Created."
  cd ${SERVER}
  # if not download and update server folder
  curl ${URL} --output ${DOWNLOAD}/${URL##*/}
  unzip -o ${DOWNLOAD}/${URL##*/} 2>&1 > /dev/null
  printf "MC Bedrock SERVER Updated."
  # restore backup
  cp ${BACKUP}/server.properties.bak ${SERVER}/server.properties
  cp ${BACKUP}/permissions.json.bak ${SERVER}/permissions.json
  cp ${BACKUP}/whitelist.json.bak ${SERVER}/whitelist.json
  printf "Backup Restored.\n"
  # Remove older copies
  find ${DOWNLOAD} -maxdepth 1 -type f -name bedrock-server\*.zip ! -newer ${DOWNLOAD}/${URL##*/} ! -name ${URL##*/} -delete

else
  printf "\nLatest Version Running.\n\n"
fi
#removes empty folder
if [ ! -d ${SERVER}/minecraftpe ] ; then
  rm ${SERVER}/minecraftpe
fi
#change server properties with variables
if [ ${DockerSet}  = "YES" ]; then
	sed -i -e "s/=19132/=${MCPort}/g" "${SERVER}/server.properties"
	sed -i -e "s/level-name=.*/level-name=${LevelName}/g" "${SERVER}/server.properties"
	sed -i -e "s/server-name=.*/server-name=${ServerName}/g" "${SERVER}/server.properties"
	sed -i -e "s/gamemode=.*/gamemode=${GameMode}/g" "${SERVER}/server.properties"
	printf "server.properties set based on Docker variables.\n"
else
	printf "Please edit server.properties manually.\n"
fi
cd ${SERVER}
LD_LIBRARY_PATH=. ./bedrock_server
