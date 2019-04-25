echo "---Install Server---"
<TODO>


echo "---Prepare Server---"
chmod -R 770 ${DATA_DIR}

echo "---Start Server---"
cd ${SERVER_DIR}
./teeworlds_srv -f ${CONFIG_DIR}/${CONFIG_FILE}
