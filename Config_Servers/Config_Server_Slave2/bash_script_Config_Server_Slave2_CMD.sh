#!/bin/bash
#This is comment

MONGO_CONFIG_SERVER_MASTER_IP_ADDR=172.17.0.1
MONGO_CONFIG_SERVER_MASTER_PORT=27001
MONGO_CONFIG_SERVER_SLAVE1_IP_ADDR=172.17.0.1
MONGO_CONFIG_SERVER_SLAVE1_PORT=27002
MONGO_CONFIG_SERVER_SLAVE2_IP_ADDR=172.17.0.1
MONGO_CONFIG_SERVER_SLAVE2_PORT=27003

MONGO_ROUTER_SERVER_IP_ADDR=172.17.0.1
MONGO_ROUTER_SERVER_PORT=27010

REDIRECT_STDERR_TO_STDOUT="2>&1"
OUTPUT_FILE="/mongo_cfg_server/SHARED_DIR/BASH_SCRIPT_FROM_CONFIG_SERVER_SLAVE2.txt"

mongod --config /etc/mongod.conf &
sleep 5
REPLICA_SET_STATUS="rs.status()"
TLS_PARAMETRS_FOR_MONGO_SHELL="--tls --host 127.0.0.1 --port 27017 --tlsCertificateKeyFile /etc/ssl/mongodb.pem --tlsCAFile /etc/ssl/rootCA.pem --tlsAllowInvalidCertificates --tlsAllowInvalidHostnames"
echo -e ${REPLICA_SET_STATUS} | mongo ${TLS_PARAMETRS_FOR_MONGO_SHELL} > ${OUTPUT_FILE} ${REDIRECT_STDERR_TO_STDOUT}
sleep 30
echo -e ${REPLICA_SET_STATUS} | mongo ${TLS_PARAMETRS_FOR_MONGO_SHELL} > ${OUTPUT_FILE} ${REDIRECT_STDERR_TO_STDOUT}
sleep infinity

