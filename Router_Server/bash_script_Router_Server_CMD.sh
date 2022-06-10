#!/bin/bash
#This is comment

MONGO_CONFIG_SERVER_MASTER_IP_ADDR=172.17.0.1
MONGO_CONFIG_SERVER_MASTER_PORT=27001
MONGO_CONFIG_SERVER_SLAVE1_IP_ADDR=172.17.0.1
MONGO_CONFIG_SERVER_SLAVE1_PORT=27002
MONGO_CONFIG_SERVER_SLAVE2_IP_ADDR=172.17.0.1
MONGO_CONFIG_SERVER_SLAVE2_PORT=27003

MONGO_SHARD1_SERVER_MASTER_IP_ADDR=172.17.0.1
MONGO_SHARD1_SERVER_MASTER_PORT=27004

MONGO_SHARD2_SERVER_MASTER_IP_ADDR=172.17.0.1
MONGO_SHARD2_SERVER_MASTER_PORT=27007

MONGO_ROUTER_SERVER_IP_ADDR=172.17.0.1
MONGO_ROUTER_SERVER_PORT=27010

REDIRECT_STDERR_TO_STDOUT="2>&1"
OUTPUT_FILE="/mongo_router_server/SHARED_DIR/BASH_SCRIPT_FROM_ROUTER_SERVER.txt"

pkill mongod 
sleep 5
sleep 100 # Waiting for other parts of the cluster to complete work
mongos --logpath /var/log/mongodb/mongod.log --fork --configdb config/${MONGO_CONFIG_SERVER_MASTER_IP_ADDR}:${MONGO_CONFIG_SERVER_MASTER_PORT},${MONGO_CONFIG_SERVER_SLAVE1_IP_ADDR}:${MONGO_CONFIG_SERVER_SLAVE1_PORT},${MONGO_CONFIG_SERVER_SLAVE2_IP_ADDR}:${MONGO_CONFIG_SERVER_SLAVE2_PORT} --bind_ip_all --tlsMode requireTLS --keyFile /mongo_router_server/auth_keyfile_for_cluster.key --tlsCertificateKeyFile /etc/ssl/mongodb.pem --tlsCAFile /etc/ssl/rootCA.pem --tlsAllowInvalidCertificates --tlsAllowInvalidHostnames
sleep 5 
SH_STATUS="sh.status()"
SH_ADD_1="sh.addShard(\"shard1/${MONGO_SHARD1_SERVER_MASTER_IP_ADDR}:${MONGO_SHARD1_SERVER_MASTER_PORT}\")"
SH_ADD_2="sh.addShard(\"shard2/${MONGO_SHARD2_SERVER_MASTER_IP_ADDR}:${MONGO_SHARD2_SERVER_MASTER_PORT}\")"

MY_DB_NAME="my_db"
DB_NAME="db"
CREATE_DB="use ${MY_DB_NAME}"
ON_SHARDING_DB="sh.enableSharding(\"${MY_DB_NAME}\")"
COLLECTION_NAME="cities"
KEY_SEGMENT_FIELD="country"
DIVISION_METHOD="hashed"
ON_SHARDING_COLLECTION="sh.shardCollection(\"${MY_DB_NAME}.${COLLECTION_NAME}\", { \"${KEY_SEGMENT_FIELD}\": \"${DIVISION_METHOD}\" })"
CREATE_COLLECTION="${DB_NAME}.createCollection(\"${COLLECTION_NAME}\")"
PATH_TO_JS_FILE="/mongo_router_server/test_data.js"
LOAD_DATA_FROM_FILE="load(\"${PATH_TO_JS_FILE}\")"
GET_ALL_RECORDS_FROM_COLLECTION="${DB_NAME}.${COLLECTION_NAME}.find()"
EXPLANE_OF_GET_ALL_RECORDS_FROM_COLLECTION="${GET_ALL_RECORDS_FROM_COLLECTION}.explain()"
FIND_FILTER_1="{\"continent\": \"Europe\"}"
FIND_FILTER_2="{\"country\": \"Japan\"}"
EXPLANE_OF_GET_WITH_FILTER_1="${DB_NAME}.${COLLECTION_NAME}.find(${FIND_FILTER_1}).explain()"
EXPLANE_OF_GET_WITH_FILTER_2="${DB_NAME}.${COLLECTION_NAME}.find(${FIND_FILTER_2}).explain()"
PATH_TO_JS_FILE_CREATE_USERS="/mongo_router_server/create_users.js"
LOAD_DATA_FROM_FILE_2="load(\"${PATH_TO_JS_FILE_CREATE_USERS}\")"
CLUSTER_ADMIN_AUTH="db.getSiblingDB(\"admin\").auth(\"config_user\", \"password2\")"
ADMIN_AUTH="db.getSiblingDB(\"admin\").auth(\"user_name\", \"password\")"
ADMIN_AUTH_FOR_MY_DB="db.getSiblingDB(\"admin\").auth(\"my_db_user\", \"password3\")"
TLS_PARAMETRS_FOR_MONGO_SHELL="--tls --host 127.0.0.1 --port 27017 --tlsCertificateKeyFile /etc/ssl/mongodb.pem --tlsCAFile /etc/ssl/rootCA.pem --tlsAllowInvalidCertificates --tlsAllowInvalidHostnames"

echo -e ${LOAD_DATA_FROM_FILE_2}\\n${CLUSTER_ADMIN_AUTH}\\n${SH_STATUS}\\n${SH_ADD_1}\\n${SH_ADD_2}\\n${SH_STATUS}\\n${ON_SHARDING_DB}\\n${ON_SHARDING_COLLECTION}\\n${ADMIN_AUTH_FOR_MY_DB}\\n${CREATE_DB}\\n${CREATE_COLLECTION}\\n${LOAD_DATA_FROM_FILE}\\n${GET_ALL_RECORDS_FROM_COLLECTION}\\n${EXPLANE_OF_GET_ALL_RECORDS_FROM_COLLECTION}\\n${EXPLANE_OF_GET_WITH_FILTER_1}\\n${EXPLANE_OF_GET_WITH_FILTER_2} | mongo ${TLS_PARAMETRS_FOR_MONGO_SHELL} >> ${OUTPUT_FILE} ${REDIRECT_STDERR_TO_STDOUT}

sleep infinity
