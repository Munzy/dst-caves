#!/bin/bash


# ====================================================================
#			DST Cave Install For Linux
# ====================================================================
#
# by:  		Cameron Munroe ~ Mun
# mysite:	http://www.cameronmunroe.com
# site:		https://qwdsa.com/c/threads/dont-starve-together-cave-installer.196/
#
# Ver:		1.7


# ====================================================================
#			Changelog
# ====================================================================

# Ver 1.7 (beta)
# Begin adding support for January 2016 full release.

# Ver 1.6
# Added better functionality for wipedst.sh

# Ver 1.5
# Added wipedst command, this deletes the current maps, but not the config. 

# Ver 1.4
# Fix a problem with update and veryify server. 

# Ver 1.0
# Initial Commit

# ====================================================================
#			Notes
# ====================================================================

# cluster_token!!!! IMPORTANT, SERVER WONT START UNLESS YOU DO THIS STEP!!!
# To generate a server token, do the following:
# Run Do Not Starve Together.   Click Play Multiplayer.
# Press tilde (~) (or ù on Azerty keyboards) to open the developer console.
# Type:  TheNet:GenerateClusterToken()
# The cluster token is written to your cluster_token.txt file located in:
# On Windows: Documents/Klei/DoNotStarveTogether
# On Linux: <USERNAME>/.klei/DoNotStarveTogether
# Please add the cluster_token.txt to ~/.klei/DoNotStarveTogether/server/cluster_token.txt

# Make sure to install steam depends!
# wget -qO- https://git.enjen.net/Munzy/Valve-Linux-Server-Installs/raw/master/deb-tf2-depend.sh  | bash


# ====================================================================
#			Download and Install SteamCMD
# ====================================================================

wget http://media.steampowered.com/installer/steamcmd_linux.tar.gz
tar -xvzf steamcmd_linux.tar.gz

# ====================================================================
#			Build Update Scripts
# ====================================================================

echo '@ShutdownOnFailedCommand 1' > update.script
echo '@NoPromptForPassword 1' >> update.script
echo 'login anonymous' >> update.script
echo 'force_install_dir dst' >> update.script
echo 'app_update 343050' >> update.script
echo 'quit' >> update.script
echo 'quit' >> update.script

echo '@ShutdownOnFailedCommand 1' > updatev.script
echo '@NoPromptForPassword 1' >> updatev.script
echo 'login anonymous' >> updatev.script
echo 'force_install_dir dst' >> updatev.script
echo 'app_update 343050 validate' >> updatev.script
echo 'quit' >> updatev.script
echo 'quit' >> updatev.script

# ====================================================================
#			Build Scripts
# ====================================================================

echo '#!/bin/bash' > updatedst.sh
echo './steamcmd.sh +runscript update.script' >> updatedst.sh

echo '#!/bin/bash' > verifydst.sh
echo './steamcmd.sh +runscript updatev.script' >> verifydst.sh

echo '#!/bin/bash' > rundst.sh
echo 'cd dst/bin/' >> rundst.sh
echo 'screen -d -m ./dontstarve_dedicated_server_nullrenderer -console -cluster server -shard master' >> rundst.sh
echo 'screen -d -m ./dontstarve_dedicated_server_nullrenderer -console -cluster server -shard cave' >> rundst.sh


echo '#!/bin/bash' > stopdst.sh
echo 'killall screen' >> stopdst.sh

echo '#!/bin/bash' > wipedst.sh
echo 'rm -rf ~/.klei/DoNotStarveTogether/server/master/save' >> wipedst.sh
echo 'rm -rf ~/.klei/DoNotStarveTogether/server/cave/save' >> wipedst.sh

chmod +x verifydst.sh
chmod +x updatedst.sh
chmod +x rundst.sh
chmod +x stopdst.sh
chmod +x wipedst.sh

# ================================================================
#		Install DST
# ================================================================

./steamcmd.sh +runscript update.script


# ====================================================================
#			Build Config
# ====================================================================
mkdir -p ~/.klei/DoNotStarveTogether/server/

touch ~/.klei/DoNotStarveTogether/server/cluster_token.txt

rm ~/.klei/DoNotStarveTogether/server/cluster.ini
echo '[GAMEPLAY]' >> ~/.klei/DoNotStarveTogether/server/cluster.ini
echo 'game_mode = endless' >> ~/.klei/DoNotStarveTogether/server/cluster.ini
echo 'max_players = 10' >> ~/.klei/DoNotStarveTogether/server/cluster.ini
echo 'pvp = false' >> ~/.klei/DoNotStarveTogether/server/cluster.ini
echo 'pause_when_empty = true' >> ~/.klei/DoNotStarveTogether/server/cluster.ini
echo '' >> ~/.klei/DoNotStarveTogether/server/cluster.ini
echo '[NETWORK]' >> ~/.klei/DoNotStarveTogether/server/cluster.ini
echo 'cluster_description = A Wonderful Description' >> ~/.klei/DoNotStarveTogether/server/cluster.ini
echo 'cluster_name = Enjen Powered' >> ~/.klei/DoNotStarveTogether/server/cluster.ini
echo 'cluster_intention = cooperative' >> ~/.klei/DoNotStarveTogether/server/cluster.ini
echo 'cluster_password =' >> ~/.klei/DoNotStarveTogether/server/cluster.ini
echo '' >> ~/.klei/DoNotStarveTogether/server/cluster.ini
echo '[MISC]' >> ~/.klei/DoNotStarveTogether/server/cluster.ini
echo 'console_enabled = true' >> ~/.klei/DoNotStarveTogether/server/cluster.ini
echo '' >> ~/.klei/DoNotStarveTogether/server/cluster.ini
echo '[SHARD]' >> ~/.klei/DoNotStarveTogether/server/cluster.ini
echo 'shard_enabled = true' >> ~/.klei/DoNotStarveTogether/server/cluster.ini
echo 'bind_ip = 127.0.0.1' >> ~/.klei/DoNotStarveTogether/server/cluster.ini
echo 'master_ip = 127.0.0.1' >> ~/.klei/DoNotStarveTogether/server/cluster.ini
echo 'master_port = 10889' >> ~/.klei/DoNotStarveTogether/server/cluster.ini
echo 'cluster_key = alongclusterpass' >> ~/.klei/DoNotStarveTogether/server/cluster.ini

mkdir -p ~/.klei/DoNotStarveTogether/server/master/
rm ~/.klei/DoNotStarveTogether/server/master/server.ini
echo '[NETWORK]' >> ~/.klei/DoNotStarveTogether/server/master/server.ini
echo 'server_port = 11000' >> ~/.klei/DoNotStarveTogether/server/master/server.ini
echo '' >> ~/.klei/DoNotStarveTogether/server/master/server.ini
echo '[SHARD]' >> ~/.klei/DoNotStarveTogether/server/master/server.ini
echo 'is_master = true' >> ~/.klei/DoNotStarveTogether/server/master/server.ini
echo '' >> ~/.klei/DoNotStarveTogether/server/master/server.ini
echo '[STEAM]' >> ~/.klei/DoNotStarveTogether/server/master/server.ini
echo 'master_server_port = 27018' >> ~/.klei/DoNotStarveTogether/server/master/server.ini
echo 'authentication_port = 8768' >> ~/.klei/DoNotStarveTogether/server/master/server.ini

mkdir -p ~/.klei/DoNotStarveTogether/server/cave/
rm ~/.klei/DoNotStarveTogether/server/cave/server.ini
echo '[NETWORK]' >> ~/.klei/DoNotStarveTogether/server/cave/server.ini
echo 'server_port = 11001' >> ~/.klei/DoNotStarveTogether/server/cave/server.ini
echo '' >> ~/.klei/DoNotStarveTogether/server/cave/server.ini
echo '[SHARD]' >> ~/.klei/DoNotStarveTogether/server/cave/server.ini
echo 'is_master = false' >> ~/.klei/DoNotStarveTogether/server/cave/server.ini
echo 'name = caves' >> ~/.klei/DoNotStarveTogether/server/cave/server.ini
echo '' >> ~/.klei/DoNotStarveTogether/server/cave/server.ini
echo '[STEAM]' >> ~/.klei/DoNotStarveTogether/server/cave/server.ini
echo 'master_server_port = 27019' >> ~/.klei/DoNotStarveTogether/server/cave/server.ini
echo 'authentication_port = 8768' >> ~/.klei/DoNotStarveTogether/server/cave/server.ini

rm ~/.klei/DoNotStarveTogether/server/cave/worldgenoverride.lua
echo 'return {' > ~/.klei/DoNotStarveTogether/server/cave/worldgenoverride.lua
echo 'override_enabled = true,' >> ~/.klei/DoNotStarveTogether/server/cave/worldgenoverride.lua
echo 'preset = "DST_CAVE",' >> ~/.klei/DoNotStarveTogether/server/cave/worldgenoverride.lua
echo '}' >> ~/.klei/DoNotStarveTogether/server/cave/worldgenoverride.lua


echo " ============================================ "
echo " \              DST + Caves                 / "
echo " \               Installed                  / "
echo " ============================================ "


