# Base system is the LTS version of Ubuntu.
FROM    ubuntu

# 25565 is for minecraft
EXPOSE  25565

# Make sure we don't get notifications we can't answer during building.
ENV DEBIAN_FRONTEND noninteractive

# Download and install everything from the repos.
RUN apt-get --quiet --yes update \
&&  apt-get --quiet --yes upgrade \
&& apt-get --quiet --yes clean
RUN apt-get --quiet --yes install curl unzip openjdk-8-jre-headless \
&& apt-get --quiet --yes clean

# create default directory
RUN	mkdir /data
WORKDIR	/data

# Load in all of our config files.
COPY /server/ops.json /data/
COPY /server/whitelist.json /data/
COPY launch.sh /data/
COPY /server/banned-ips.json /data/
COPY /server/banned-players.json /data/
COPY /server/eula.txt /data/
COPY /server/server.properties /data/

# download technicpack
RUN curl -s "http://files.theclassicpack.com/SERVER/TCP-3.0.9c_SERVER.zip" -o /data/_SERVER.zip
RUN unzip _SERVER.zip \
&& rm _SERVER.zip

# disable mods
RUN mkdir -p mods/disabled