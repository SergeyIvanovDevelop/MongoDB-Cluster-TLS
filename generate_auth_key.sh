#!/bin/bash
#This is comment

PATH_TO_KEY_FILE="auth_keyfile_for_cluster.key"
MAX_KEY_LENGTH=756 # 768


sudo rm ./Config_Servers/Config_Server_Master/${PATH_TO_KEY_FILE} | true
sudo rm ./Config_Servers/Config_Server_Slave1/${PATH_TO_KEY_FILE} | true
sudo rm ./Config_Servers/Config_Server_Slave2/${PATH_TO_KEY_FILE} | true
sudo rm ./Shard1_Servers/Shard1_Server_Master/${PATH_TO_KEY_FILE} | true
sudo rm ./Shard1_Servers/Shard1_Server_Slave1/${PATH_TO_KEY_FILE} | true
sudo rm ./Shard1_Servers/Shard1_Server_Slave2/${PATH_TO_KEY_FILE} | true
sudo rm ./Shard2_Servers/Shard2_Server_Master/${PATH_TO_KEY_FILE} | true
sudo rm ./Shard2_Servers/Shard2_Server_Slave1/${PATH_TO_KEY_FILE} | true
sudo rm ./Shard2_Servers/Shard2_Server_Slave2/${PATH_TO_KEY_FILE} | true
sudo rm ./Router_Server/${PATH_TO_KEY_FILE} | true
sudo rm ./Auth_Key/${PATH_TO_KEY_FILE} | true
sudo rm ${PATH_TO_KEY_FILE} | true

openssl rand -base64 ${MAX_KEY_LENGTH} > ${PATH_TO_KEY_FILE}

cp ${PATH_TO_KEY_FILE} ./Config_Servers/Config_Server_Master
cp ${PATH_TO_KEY_FILE} ./Config_Servers/Config_Server_Slave1
cp ${PATH_TO_KEY_FILE} ./Config_Servers/Config_Server_Slave2
cp ${PATH_TO_KEY_FILE} ./Shard1_Servers/Shard1_Server_Master
cp ${PATH_TO_KEY_FILE} ./Shard1_Servers/Shard1_Server_Slave1
cp ${PATH_TO_KEY_FILE} ./Shard1_Servers/Shard1_Server_Slave2
cp ${PATH_TO_KEY_FILE} ./Shard2_Servers/Shard2_Server_Master
cp ${PATH_TO_KEY_FILE} ./Shard2_Servers/Shard2_Server_Slave1
cp ${PATH_TO_KEY_FILE} ./Shard2_Servers/Shard2_Server_Slave2
cp ${PATH_TO_KEY_FILE} ./Router_Server
cp ${PATH_TO_KEY_FILE} ./Auth_Key # for application

sudo chown mongodb:mongodb ./Config_Servers/Config_Server_Master/${PATH_TO_KEY_FILE}
sudo chown mongodb:mongodb ./Config_Servers/Config_Server_Slave1/${PATH_TO_KEY_FILE}
sudo chown mongodb:mongodb ./Config_Servers/Config_Server_Slave2/${PATH_TO_KEY_FILE}
sudo chown mongodb:mongodb ./Shard1_Servers/Shard1_Server_Master/${PATH_TO_KEY_FILE}
sudo chown mongodb:mongodb ./Shard1_Servers/Shard1_Server_Slave1/${PATH_TO_KEY_FILE}
sudo chown mongodb:mongodb ./Shard1_Servers/Shard1_Server_Slave2/${PATH_TO_KEY_FILE}
sudo chown mongodb:mongodb ./Shard2_Servers/Shard2_Server_Master/${PATH_TO_KEY_FILE}
sudo chown mongodb:mongodb ./Shard2_Servers/Shard2_Server_Slave1/${PATH_TO_KEY_FILE}
sudo chown mongodb:mongodb ./Shard2_Servers/Shard2_Server_Slave2/${PATH_TO_KEY_FILE}
sudo chown mongodb:mongodb ./Router_Server/${PATH_TO_KEY_FILE}
sudo chown mongodb:mongodb ./Auth_Key/${PATH_TO_KEY_FILE}
sudo chown mongodb:mongodb ${PATH_TO_KEY_FILE}

sudo chmod 400 ./Config_Servers/Config_Server_Master/${PATH_TO_KEY_FILE}
sudo chmod 400 ./Config_Servers/Config_Server_Slave1/${PATH_TO_KEY_FILE}
sudo chmod 400 ./Config_Servers/Config_Server_Slave2/${PATH_TO_KEY_FILE}
sudo chmod 400 ./Shard1_Servers/Shard1_Server_Master/${PATH_TO_KEY_FILE}
sudo chmod 400 ./Shard1_Servers/Shard1_Server_Slave1/${PATH_TO_KEY_FILE}
sudo chmod 400 ./Shard1_Servers/Shard1_Server_Slave2/${PATH_TO_KEY_FILE}
sudo chmod 400 ./Shard2_Servers/Shard2_Server_Master/${PATH_TO_KEY_FILE}
sudo chmod 400 ./Shard2_Servers/Shard2_Server_Slave1/${PATH_TO_KEY_FILE}
sudo chmod 400 ./Shard2_Servers/Shard2_Server_Slave2/${PATH_TO_KEY_FILE}
sudo chmod 400 ./Router_Server/${PATH_TO_KEY_FILE}
sudo chmod 400 ./Auth_Key/${PATH_TO_KEY_FILE}
sudo chmod 400 ${PATH_TO_KEY_FILE}

echo "OpenSSL successfull generated key for auth_in_replic_shard_set !"

