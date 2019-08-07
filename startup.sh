#!/bin/bash

BASE_URL='https://www.minecraft.net/en-us/download/server/bedrock/'
SERVER=${MCSERVERFOLDER}/server
DOWNLOAD=${MCSERVERFOLDER}/download
BACKUP=${MCSERVERFOLDER}/backup

#checks if folders exist
    if [ -d ${DOWNLOAD} ] ; then
        echo  "${DOWNLOAD} already exists."
        else
        mkdir -p ${DOWNLOAD}
        echo  "${DOWNLOAD} created."
    fi
    if [ -d ${SERVER} ] ; then
        echo  "${SERVER} already exists."
        else
        mkdir -p ${SERVER}
        echo  "${SERVER} created."
    fi
    if [ -d ${BACKUP} ] ; then
        echo  "${BACKUP} already exists."
        else
        mkdir -p ${BACKUP}
        echo  "${BACKUP} created."
    fi

# checks if latests ver downloaded
URL=`curl -L ${BASE_URL} 2>/dev/null| grep bin-linux | sed -e 's/.*<a href=\"\(https:.*\/bin-linux\/.*\.zip\).*/\1/'`
if [ ! -e ${DOWNLOAD}/${URL##*/} ] ; then
  #creates backup before update
  cp ${SERVER}/server.properties ${BACKUP}/server.properties.bak
  cp ${SERVER}/permissions.json ${BACKUP}/permissions.json.bak
  cp ${SERVER}/whitelist.json ${BACKUP}/whitelist.json.bak
  echo "Backup Created"
  cd ${SERVER}
  # if not download and update server folder
  curl ${URL} --output ${DOWNLOAD}/${URL##*/}
  unzip -o ${DOWNLOAD}/${URL##*/} 2>&1 > /dev/null
  echo "MC Bedrock Server Updated"
  # restore backup
  cp ${BACKUP}/server.properties.bak ${SERVER}/server.properties
  cp ${BACKUP}/permissions.json.bak ${SERVER}/permissions.json
  cp ${BACKUP}/whitelist.json.bak ${SERVER}/whitelist.json
  echo "Backup Restored"
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
sed -i -e "s/=19132/=${MCPORT}/g" "${SERVER}/server.properties"
sed -i -e "s/level-name=.*/level-name=${WORLD}/g" "${SERVER}/server.properties"
cd ${SERVER}
LD_LIBRARY_PATH=. ./bedrock_server
