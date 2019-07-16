# Base system is the LTS version of Ubuntu.
FROM    ubuntu

# 25565 is for minecraft
EXPOSE  25565

# Make sure we don't get notifications we can't answer during building.
ENV DEBIAN_FRONTEND noninteractive

# Download and install everything from the repos.
RUN apt-get --quiet --yes update && apt-get --quiet --yes upgrade && apt-get --quiet --yes clean
RUN apt-get --quiet --yes install curl unzip openjdk-8-jre-headless && apt-get --quiet --yes clean

# create default directory
RUN	mkdir /data
WORKDIR	/data

# Load in all of our config files.
ADD ops.json /data/
ADD whitelist.json /data/
ADD launch.sh /data/
ADD banned-ips.json /data/
ADD banned-players.json /data/
ADD eula.txt /data/
ADD server.properties /data/

# download technicpack
RUN curl -s "http://files.theclassicpack.com/SERVER/TCP-3.0.9c_SERVER.zip" -o /data/_SERVER.zip
RUN unzip _SERVER.zip && rm _SERVER.zip

# disable mods
RUN mkdir -p mods/disabled
#RUN	mv mods/morph*.zip mods/disabled/

# Fix permissions
RUN chmod +x launch.sh

# /start runs it.
CMD ["./launch.sh"]