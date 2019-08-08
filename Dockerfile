FROM buildpack-deps:bionic-curl

ENV DockerSet="NO"
ENV MCPort=19132
ENV MCFolder=/home/bedrockserver
ENV LevelName="Bedrock level"
ENV ServerName="Dedicated Server"
ENV GameMode="survival"

# install curl and unzip
RUN apt-get update
RUN apt-get install -y curl unzip

# set up startup script
COPY startup.sh /home/
RUN chmod +x /home/startup.sh
ENTRYPOINT ["/home/startup.sh"]
