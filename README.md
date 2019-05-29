# Teeworlds in Docker optimized for Unraid

This Docker will download and install a simple Teeworlds Dedicated server with a autoexec.cfg, dm.cfg, tdm.cfg & ctf.cfg preconfigured (the only thing that need to be changed is the Server Name and the RCON Password in the autoexec.cfg).

## Env params
| Name | Value | Example |
| --- | --- | --- |
| DATA_DIR | Folder for Serverdata | /serverdata |
| SERVER_DIR | Folder for Teeworlds | /serverdata/serverfiles |
| GAME_CONFIG | dm.cfg, ctf.cfg, tdm.cfg,... | dm.cfg |
| UID | User Identifier | 99 |
| GID | Group Identifier | 100 |
| GAME_PORT | Port the server will be running on | 8303 |

## Run example
```
docker run --name Teeworlds -d \
	-p 8303:8303 -p 8303:8303/udp \
	--env 'GAME_CONFIG=dm.cfg' \
	--env 'UID=99' \
	--env 'GID=100' \
	--volume /mnt/user/appdata/teeworlds:/serverdata/serverfiles \
	ich777/teeworldsserver:latest
```

***ATTENTION: Please don't delete the tar.gz file in the main directory!***

Update Notice: Simply restart the container if a newer version of the game is available and the container will download and install it.

#### Support Thread: https://forums.unraid.net/topic/79530-support-ich777-gameserver-dockers/