FROM buildpack-deps:bionic-curl

ENV DockerSet="YES"
ENV MCPort=19132
ENV MCFolder=/home/bedrockserver
ENV LevelName="Bedrock Server"
ENV ServerName="Bedrock Server"
ENV GameMode="survival"


EXPOSE $MCPort
EXPOSE $MCPort/UPD
# install curl and unzip
RUN apt-get update
RUN apt-get install -y curl unzip

# set up startup script
COPY startup.sh /home/
RUN chmod +x /home/startup.sh
ENTRYPOINT ["/home/startup.sh"]
