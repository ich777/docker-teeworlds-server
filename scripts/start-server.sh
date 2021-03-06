#!/bin/bash
CUR_V="$(find -name teeworlds[^extended]*\.tar\.gz | cut -d '-' -f 2)"
LAT_V="$(curl -s https://api.github.com/repos/teeworlds/teeworlds/releases/latest | grep tag_name | cut -d '"' -f4)"

if [ -z "$CUR_V" ]; then
   echo "---Teeworlds not found!---"
   cd ${SERVER_DIR}
   curl -s https://api.github.com/repos/teeworlds/teeworlds/releases/latest \
   | grep "browser_download_url.*teeworlds-[^extended].*-linux_x86_64\.tar\.gz" \
   | cut -d ":" -f 2,3 \
   | cut -d '"' -f2 \
   | wget -qi -
   tar --directory ${SERVER_DIR} -xvzf /serverdata/serverfiles/teeworlds-$LAT_V-linux_x86_64.tar.gz
   mv ${SERVER_DIR}/teeworlds-$LAT_V-linux_x86_64 ${SERVER_DIR}/teeworlds  
elif [ "$LAT_V" != "$CUR_V" ]; then
   echo "---Newer version found, installing!---"
   rm ${SERVER_DIR}/teeworlds-$CUR_V-linux_x86_64.tar.gz
   cd ${SERVER_DIR}
   curl -s https://api.github.com/repos/teeworlds/teeworlds/releases/latest \
   | grep "browser_download_url.*teeworlds-[^extended].*-linux_x86_64\.tar\.gz" \
   | cut -d ":" -f 2,3 \
   | cut -d '"' -f2 \
   | wget -qi -
   tar --directory ${SERVER_DIR} -xvzf /serverdata/serverfiles/teeworlds-$LAT_V-linux_x86_64.tar.gz
   mv ${SERVER_DIR}/teeworlds-$LAT_V-linux_x86_64 ${SERVER_DIR}/teeworlds
elif [ "$LAT_V" == "$CUR_V" ]; then
   echo "---Teeworlds Version up-to-date---"
else
   echo "---Something went wrong, putting server in sleep mode---"
   sleep infinity
fi

echo "---Preparing Server---"
if [ ! -f ${SERVER_DIR}/teeworlds/autoexec.cfg ]; then
   cd ${SERVER_DIR}/teeworlds
   if wget -q -nc --show-progress --progress=bar:force:noscroll https://raw.githubusercontent.com/ich777/docker-teeworlds-server/master/configs/autoexec.cfg ; then
   	echo "---Successfully downloaded 'autoexec.cfg'---"
   else
   	echo "---Can't download 'autoexec.cfg', continuing...---"
   fi
   if wget -q -nc --show-progress --progress=bar:force:noscroll https://raw.githubusercontent.com/ich777/docker-teeworlds-server/master/configs/ctf.cfg ; then
	echo "---Successfully downloaded 'ctf.cfg'---"
   else
   	echo "---Can't download 'ctf.cfg', continuing...---"
   fi
   if wget -q -nc --show-progress --progress=bar:force:noscroll https://raw.githubusercontent.com/ich777/docker-teeworlds-server/master/configs/dm.cfg ; then
	echo "---Successfully downloaded 'dm.cfg'---"
   else
   	echo "---Can't download 'dm.cfg', continuing...---"
   fi
   if wget -q -nc --show-progress --progress=bar:force:noscroll https://raw.githubusercontent.com/ich777/docker-teeworlds-server/master/configs/tdm.cfg ; then
	echo "---Successfully downloaded 'tdm.cfg'---"
   else
   	echo "---Can't download 'tdm.cfg', continuing...---"
   fi
fi
chmod -R ${DATA_PERM} ${DATA_DIR}

echo "---Starting Server---"
cd ${SERVER_DIR}/teeworlds
./teeworlds_srv -f ${GAME_CONFIG}