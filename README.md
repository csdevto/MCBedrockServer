# MCPEBedrockServer
After checking online for a good Minecraft Bedrock Server for docker that updates after every restart, I decided to create my own Docker Image.
This is a very simple image, it downloads the latest version from the webiste, backs up server.properties, whitelist.json and permissions.json and restores them once it has been updated.

To run with docker use 
```
 docker run \
    --name MCPE \
    --interactive \
    --tty \
    --detach \
    -p 19132:19132/udp \
    -p 19132:19132 \
  csdevto/mcbsrv:latest
 ```
 To run while creating a volume
 ```
  docker run \
    --name MCPE \
    --interactive \
    --tty \
    --detach \
    --restart unless-stopped \
    -p 19132:19132/udp \
    -p 19132:19132 \
    -v {your folder path}:/home/bedrockserver \
  csdevto/mcbsrv:latest
  ```
  you can add more variables such as world name, port to use, folder location inside docker, if you change the MCPORT you should also change the ports exposed (UDP and TCP) and if you change MCSERVERFOLDER make sure the volume path inside docker matches the  path
  ```
    docker run \
    --name MCPE \
    --interactive \
    --tty \
    --detach \
    --restart unless-stopped \
    -p 19132:19132/udp \
    -p 19132:19132 \
    -e MCPORT=19132 \
    -e WORLD="Bedrock Server" \
    -e MCSERVERFOLDER="/home/bedrockserver" \
    -v {your folder path}:/home/bedrockserver \
  csdevto/mcbsrv:latest
  ```
  I'm open to any suggestions or changes.
  
  
