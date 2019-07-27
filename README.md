<p align="center">
  <img width="389" height="235" src="https://raw.githubusercontent.com/Marascon/Dockerized-Minecraft/master/documentation/logo.png">
</p>

# docker-technicpack-minecraft
A simple dockerfile to start up TechnicPack servers

## Work in progress
A functional docker image will be pushed once this turns out to work as expected. 
**Todo:**
- Implement different worlds into same volume
- ~~Make image size smaller~~
- ~~Remove unneeded file copies~~
- ~~Use environment settings to configure minecraft server~~

# Use locally
Follow these steps to setup your minecraft server:

**1). Create specific volume**
- This volumes holds the generated worldcraft map.
  `docker volume create minecraft-servername`

**2). Build the image**
- Build latest image locally: `docker build . -t minecraft-docker-server:latest`
  Do this before running `docker-compose up`
  
**3). Run the image with docker-compose.yml**
- Copy, paste and edit the 'docker-compose.yml'
  ```yml
version: '3.7'

volumes:
  minecraft-server:
    external: true

services:
  minecraft:
    image: minecraft-docker-server:latest
    ports:
      - 25565:25565
    volumes:
      - minecraft-server:/data/world
    environment:
      - MAX_TICK_TIME=60000
      - FORCE_GAMEMODE=false
      - ALLOW_NETHER=true
      - GAMEMODE=0
      - ENABLE_QUERY=false
      - PLAYER_IDLE_TIMEOUT=0
      - DIFFICULTY=2
      - SPAWN_MONSTERS=true
      - OP_PERMISSION_LEVEL=4
      - PVP=true
      - SNOOPER_ENABLED=true
      - LEVEL_TYPE=DEFAULT
      - HARDCORE=false
      - ENABLE_COMMAND_BLOCK=false
      - MAX_PLAYERS=20
      - NETWORK_COMPRESSION_THRESHOLD=256
      - MAX_WORLD_SIZE=29999984
      - SERVER_PORT=25565
      - SPAWN_NPCS=true
      - ALLOW_FLIGHT=false
      - LEVEL_NAME=world
      - VIEW_DISTANCE=10
      - SPAWN_ANIMALS=true
      - WHITE_LIST=false
      - GENERATE_STRUCTURES=true
      - ONLINE_MODE=true
      - MAX_BUILD_HEIGHT=256
      - PREVENT_PROXY_CONNECTIONS=false
      - USE_NATIVE_TRANSPORT=true
      - MOTD=PrutsersUnited Minecraft Server
      - ENABLE_RCON=false
  ```
