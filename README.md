# Minecraft Bedrock Server - csdevto/mcbsrv
Docker hub: https://hub.docker.com/r/csdevto/mcbsrv

Github: https://github.com/csdevto/MCBedrockServer

After checking online for a good Minecraft Bedrock Server for docker that updates after every restart, I decided to create my own Docker Image.
This is a very simple image, it downloads the latest version from the webiste, backs up server.properties, whitelist.json and permissions.json and restores them once it has been updated.

To run with docker use 
```
 docker run \
    --name MinecraftBedrockServer \
    --interactive \
    --tty \
    --detach \
    -p 19132:19132/udp \
    -p 19132:19132 \
  csdevto/mcbsrv:latest
 ```
 you can set a volume to edit the server setting or upload your own worlds by using
 ```
  docker run \
    --name MinecraftBedrockServer \
    --interactive \
    --tty \
    --detach \
    --restart unless-stopped \
    -p 19132:19132/udp \
    -p 19132:19132 \
    -e DockerSet="NO" \
    -v {your folder path}:/home/bedrockserver \
  csdevto/mcbsrv:latest
  ```
  you can add more variables such as world name, port to use, Game Mode, Server Name, Level Name, folder location inside docker, if you change the MCPORT you should also change the ports exposed (UDP and TCP) and if you change MCSERVERFOLDER make sure the volume path inside docker matches the  path
  ```
    docker run \
      --name MinecraftBedrockServer \
      --interactive \
      --tty \
      --detach \
      --restart unless-stopped \
      -p 19132:19132/udp \
      -p 19132:19132 \
      -e DockerSet="YES" \
      -e MCPort=19132 \
      -e ServerName="Dedicated Server" \
      -e LevelName="Bedrock level" \
      -e GameMode="survival" \
      -e MCFolder="/home/bedrockserver" \
      -v {your folder path}:/home/bedrockserver \
    csdevto/mcbsrv:latest
  ```

  All the possible Variables that can be used are

| Command | Default | Description |
| --- | --- | --- |
| DockerSet | NO | Set YES if you want to edit the server.settings folder from docker|
| MCPort | 19132 | Which IPv4 port the server should listen to. Change the exposed ports as well. Allowed values: Integers in the range [1, 65535]|
| ServerName| Dedicated Server | Used as the server name |
| LevelName | Bedrock level | Change for different Level Name |
| GameMode | survival | Allowed values: "survival", "creative", or "adventure" |
| MCFolder | /home/bedrockserver | Folder where everything is saved |

  I'm open to any suggestions or changes.
  
