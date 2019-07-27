#!/bin/sh

# list of available configuration options
configurationoptions="MAX_TICK_TIME GENERATOR_SETTINGS FORCE_GAMEMODE ALLOW_NETHER GAMEMODE ENABLE_QUERY PLAYER_IDLE_TIMEOUT DIFFICULTY SPAWN_MONSTERS OP_PERMISSION_LEVEL PVP SNOOPER_ENABLED LEVEL_TYPE HARDCORE ENABLE_COMMAND_BLOCK MAX_PLAYERS NETWORK_COMPRESSION_THRESHOLD RESOURCE_PACK_SHA1 MAX_WORLD_SIZE SERVER_PORT SERVER_IP SPAWN_NPCS ALLOW_FLIGHT LEVEL_NAME VIEW_DISTANCE RESOURCE_PACK SPAWN_ANIMALS WHITE_LIST GENERATE_STRUCTURES ONLINE_MODE MAX_BUILD_HEIGHT LEVEL_SEED PREVENT_PROXY_CONNECTIONS USE_NATIVE_TRANSPORT MOTD ENABLE_RCON"

# make sure we have a empty autoexec.cfg file
if [[ ! -e /data/server.properties ]]; then
    touch /data/server.properties
fi
> /data/server.properties

# retrieve all configured server settings and write them to the configuration file
for option in ${configurationoptions}
do
    eval envvar='$'${option}
    if [[ ! -z "${envvar}" ]]; then
        echo $(echo ${option} | tr '[:upper:]' '[:lower:]' | sed 's/_/-/g')'='${envvar} >> /data/server.properties
    fi
done

# default settings
echo "server-ip=0.0.0.0" >> /data/server.properties

echo ''
echo '***********************************************'
echo 'Generated the following server configuration: '
echo '***********************************************'
cat /data/server.properties
echo '***********************************************'
echo ''
echo ''
echo '***********************************************'
echo 'Booting game'
echo '***********************************************'

# Actually run the game now
java -Xms1024M -Xmx1536M -jar Forge.jar nogui
