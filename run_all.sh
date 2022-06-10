#!/bin/bash
#This is comment

./correct_files.sh

cd tls_key_generating/ && ./fast_gen_for_tls.sh

cd ../

cp ./tls_key_generating/rootCA.pem ./Config_Servers/Config_Server_Master
cp ./tls_key_generating/KEYS_AND_SERT/mongodb_1.pem ./Config_Servers/Config_Server_Master/mongodb.pem

cp ./tls_key_generating/rootCA.pem ./Config_Servers/Config_Server_Slave1
cp ./tls_key_generating/KEYS_AND_SERT/mongodb_2.pem ./Config_Servers/Config_Server_Slave1/mongodb.pem

cp ./tls_key_generating/rootCA.pem ./Config_Servers/Config_Server_Slave2
cp ./tls_key_generating/KEYS_AND_SERT/mongodb_3.pem ./Config_Servers/Config_Server_Slave2/mongodb.pem

cp ./tls_key_generating/rootCA.pem ./Shard1_Servers/Shard1_Server_Master
cp ./tls_key_generating/KEYS_AND_SERT/mongodb_4.pem ./Shard1_Servers/Shard1_Server_Master/mongodb.pem

cp ./tls_key_generating/rootCA.pem ./Shard1_Servers/Shard1_Server_Slave1
cp ./tls_key_generating/KEYS_AND_SERT/mongodb_5.pem ./Shard1_Servers/Shard1_Server_Slave1/mongodb.pem

cp ./tls_key_generating/rootCA.pem ./Shard1_Servers/Shard1_Server_Slave2
cp ./tls_key_generating/KEYS_AND_SERT/mongodb_6.pem Shard1_Servers/Shard1_Server_Slave2/mongodb.pem

cp ./tls_key_generating/rootCA.pem ./Shard2_Servers/Shard2_Server_Master
cp ./tls_key_generating/KEYS_AND_SERT/mongodb_7.pem ./Shard2_Servers/Shard2_Server_Master/mongodb.pem

cp ./tls_key_generating/rootCA.pem ./Shard2_Servers/Shard2_Server_Slave1
cp ./tls_key_generating/KEYS_AND_SERT/mongodb_8.pem ./Shard2_Servers/Shard2_Server_Slave1/mongodb.pem

cp ./tls_key_generating/rootCA.pem ./Shard2_Servers/Shard2_Server_Slave2
cp ./tls_key_generating/KEYS_AND_SERT/mongodb_9.pem ./Shard2_Servers/Shard2_Server_Slave2/mongodb.pem

cp ./tls_key_generating/rootCA.pem ./Router_Server
cp ./tls_key_generating/KEYS_AND_SERT/mongodb_10.pem ./Router_Server/mongodb.pem

sudo docker-compose config 

if [ $1 = "build" ]
then
	./generate_auth_key.sh
	echo "Building images with \"--no-cache\" ..."
	sleep 5
	sudo docker-compose build --no-cache
	sleep 5
	echo Docker containers configured and built successfully.
fi

if [ $1 = "rebuild" ]
then
	./generate_auth_key.sh
	echo "Rebuilding images with \"cache\" ..."
	sleep 5
	sudo docker-compose build
	sleep 5
	echo Docker containers configured and rebuilt successfully.
fi

if [ $1 = "run" ]
then
	echo "Building images \"with cache\" and running containers ..."
	sleep 5
	sudo docker-compose up --detach --force-recreate
	sleep 5
	echo Docker containers configured, built and launched successfully.
fi
