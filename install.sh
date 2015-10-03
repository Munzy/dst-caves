#!/bin/bash


# ====================================================================
#			DST Cave Install For Linux
# ====================================================================
#
# by:  		Cameron Munroe ~ Mun
# mysite:	http://www.cameronmunroe.com
# site:		https://qwdsa.com/c/threads/dont-starve-together-cave-installer.196/
#
# Ver:		1.6


# ====================================================================
#			Changelog
# ====================================================================

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

# Server Token!!!! IMPORTANT WONT START UNLESS YOU DO THIS STEP
# 
# To generate a server token, do the following:
# Run Donâ€™t Starve Together.   Click Play Multiplayer.
# Press tilde (~) (or Ã¹ on Azerty keyboards) to open the developer console.
# Type:  TheNet:GenerateServerToken()
# The server token is written to your log.txt file located in:
# On Windows: /My Documents/Klei/DoNotStarveTogether /log.txt
# On Linux: /<USERNAME>/.klei/DoNotStarveTogether/log.txt
# 
# Grab the token from (near) the bottom of your log.txt file.
# 
# Add your server token to your servers settings.ini
# On Windows: Documents/Klei/DoNotStarveTogether/Settings.ini
# On Linux: /<USERNAME>/.klei/DoNotStarveTogether/Settings.ini
#  
# Look for a heading that reads [account]  if this heading does not exist, add it to the bottom of the file.  
# 
# Under [account] add this line:
# server_token = Server token Generated From TheNet:GenerateServerToken() 
#   
# NOTE: You can re-use a single server_token on multiple servers
# NOTE: Your save directory, log.txt and settings.ini files are created the first time you start the server or game client.
# NOTE: We will attempt to automate this in the future.  

# Make sure to install steam depends!
# wget -O - https://cdn.content-network.net/sc/deb-tf2-depend.sh | bash

# also install
# libcurl4-gnutls-dev:i386


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
echo 'app_update 343050 -beta cavesbeta' >> update.script
echo 'quit' >> update.script
echo 'quit' >> update.script

echo '@ShutdownOnFailedCommand 1' > updatev.script
echo '@NoPromptForPassword 1' >> updatev.script
echo 'login anonymous' >> updatev.script
echo 'force_install_dir dst' >> updatev.script
echo 'app_update 343050 -beta cavesbeta validate' >> updatev.script
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
echo 'screen -d -m ./dontstarve_dedicated_server_nullrenderer -console' >> rundst.sh
echo 'screen -d -m ./dontstarve_dedicated_server_nullrenderer  -conf_dir cave -console' >> rundst.sh


echo '#!/bin/bash' > stopdst.sh
echo 'killall screen' >> stopdst.sh

echo '#!/bin/bash' > wipedst.sh
echo 'rm -rf ~/.klei/DoNotStarveTogether/save' >> wipedst.sh
echo 'rm -rf ~/.klei/cave/save' >> wipedst.sh

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
mkdir -p ~/.klei/DoNotStarveTogether/

echo '[network]' > ~/.klei/DoNotStarveTogether/settings.ini
echo 'default_server_name = DST Server - Main' >> ~/.klei/DoNotStarveTogether/settings.ini
echo 'default_server_discription = DST Server With Caves' >> ~/.klei/DoNotStarveTogether/settings.ini
echo 'server_port = 10999' >> ~/.klei/DoNotStarveTogether/settings.ini
echo 'server_password = ' >> ~/.klei/DoNotStarveTogether/settings.ini
echo 'max_players = 10' >> ~/.klei/DoNotStarveTogether/settings.ini
echo 'pvp = false' >> ~/.klei/DoNotStarveTogether/settings.ini
echo 'game_mode = endless' >> ~/.klei/DoNotStarveTogether/settings.ini
echo 'enable_autosaver = true' >> ~/.klei/DoNotStarveTogether/settings.ini
echo 'tick_rate = 30' >> ~/.klei/DoNotStarveTogether/settings.ini
echo 'connection_timeout = 8000' >> ~/.klei/DoNotStarveTogether/settings.ini
echo 'pause_when_empty = true' >> ~/.klei/DoNotStarveTogether/settings.ini
echo 'steam_group_id = ' >> ~/.klei/DoNotStarveTogether/settings.ini
echo 'steam_group_only = false' >> ~/.klei/DoNotStarveTogether/settings.ini
echo 'offline_server = false' >> ~/.klei/DoNotStarveTogether/settings.ini
echo '' >> ~/.klei/DoNotStarveTogether/settings.ini
echo '[account]' >> ~/.klei/DoNotStarveTogether/settings.ini
echo 'server_token = Config me' >> ~/.klei/DoNotStarveTogether/settings.ini
echo '' >> ~/.klei/DoNotStarveTogether/settings.ini
echo '[MISC]' >> ~/.klei/DoNotStarveTogether/settings.ini
echo 'CONSOLE_ENABLED = true' >> ~/.klei/DoNotStarveTogether/settings.ini
echo 'autocompiler_enabled = true' >> ~/.klei/DoNotStarveTogether/settings.ini
echo '' >> ~/.klei/DoNotStarveTogether/settings.ini
echo '[shard]' >> ~/.klei/DoNotStarveTogether/settings.ini
echo 'shard_enable = true' >> ~/.klei/DoNotStarveTogether/settings.ini
echo 'is_master = true' >> ~/.klei/DoNotStarveTogether/settings.ini
echo 'master_port = 11200' >> ~/.klei/DoNotStarveTogether/settings.ini
echo 'cluster_key = qwdsa' >> ~/.klei/DoNotStarveTogether/settings.ini
echo '' >> ~/.klei/DoNotStarveTogether/settings.ini

mkdir -p ~/.klei/cave/

echo '[network]' > ~/.klei/cave/settings.ini
echo 'default_server_name = DST Server - Cave' >> ~/.klei/cave/settings.ini
echo 'default_server_discription = DST Server With Caves' >> ~/.klei/cave/settings.ini
echo 'server_port = 11001' >> ~/.klei/cave/settings.ini
echo 'steam_authentication_port = 12348' >> ~/.klei/cave/settings.ini
echo 'steam_master_server_port = 12349' >> ~/.klei/cave/settings.ini
echo 'server_password = ' >> ~/.klei/cave/settings.ini
echo 'max_players = 10' >> ~/.klei/cave/settings.ini
echo 'pvp = false' >> ~/.klei/cave/settings.ini
echo 'game_mode = endless' >> ~/.klei/cave/settings.ini
echo 'enable_autosaver = true' >> ~/.klei/cave/settings.ini
echo 'tick_rate = 30' >> ~/.klei/cave/settings.ini
echo 'connection_timeout = 8000' >> ~/.klei/cave/settings.ini
echo 'pause_when_empty = true' >> ~/.klei/cave/settings.ini
echo 'steam_group_id = ' >> ~/.klei/cave/settings.ini
echo 'steam_group_only = false' >> ~/.klei/cave/settings.ini
echo 'offline_server = false' >> ~/.klei/cave/settings.ini
echo '' >> ~/.klei/cave/settings.ini
echo '[account]' >> ~/.klei/cave/settings.ini
echo 'server_token = config me ' >> ~/.klei/cave/settings.ini
echo '' >> ~/.klei/cave/settings.ini
echo '[MISC]' >> ~/.klei/cave/settings.ini
echo 'CONSOLE_ENABLED = true' >> ~/.klei/cave/settings.ini
echo 'autocompiler_enabled = true' >> ~/.klei/cave/settings.ini
echo '' >> ~/.klei/cave/settings.ini
echo '[shard]' >> ~/.klei/cave/settings.ini
echo 'shard_enable = true' >> ~/.klei/cave/settings.ini
echo 'is_master = false' >> ~/.klei/cave/settings.ini
echo 'master_ip = 127.0.0.1' >> ~/.klei/cave/settings.ini
echo 'master_port = 11200' >> ~/.klei/cave/settings.ini
echo 'shard_name = caves' >> ~/.klei/cave/settings.ini
echo 'cluster_key = qwdsa' >> ~/.klei/cave/settings.ini
echo '' >> ~/.klei/cave/settings.ini

echo 'return {' > ~/.klei/cave/worldgenoverride.lua
echo 'override_enabled = true,' >> ~/.klei/cave/worldgenoverride.lua
echo 'preset = "DST_CAVE",' >> ~/.klei/cave/worldgenoverride.lua
echo '}' >> ~/.klei/cave/worldgenoverride.lua


echo " ============================================ "
echo " \              DST + Caves                 / "
echo " \               Installed                  / "
echo " \                                          / "
echo " \     Make sure to edit settings.ini       / "
echo " \        in ~/.klei/*/settings.ini         / "
echo " \      and add your server_token key       / "
echo " ============================================ "


