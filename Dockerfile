FROM buildpack-deps:bionic-curl

ENV MCPORT=19132
ENV MCPORT=19132/UDP
ENV MCSERVERFOLDER=/home/bedrockserver
ENV WORLD="Bedrock Server"

EXPOSE $MCPORT

# install curl and unzip
RUN apt-get update
RUN apt-get install -y curl unzip

# set up startup script
COPY startup.sh /home/
RUN chmod +x /home/startup.sh
ENTRYPOINT ["/home/startup.sh"]
