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
OUTPUT_FILE="/mongo_cfg_server/SHARED_DIR/BASH_SCRIPT_FROM_CONFIG_SERVER_MASTER.txt"

mongod --config /etc/mongod.conf &
sleep 20
CONFIG_REPLIC_SET="rs.initiate({_id: \"config\", members: [{_id: 0, host: \"$MONGO_CONFIG_SERVER_MASTER_IP_ADDR:$MONGO_CONFIG_SERVER_MASTER_PORT\", priority: 2}, {_id: 1, host: \"$MONGO_CONFIG_SERVER_SLAVE1_IP_ADDR:$MONGO_CONFIG_SERVER_SLAVE1_PORT\"}, {_id: 2, host: \"$MONGO_CONFIG_SERVER_SLAVE2_IP_ADDR:$MONGO_CONFIG_SERVER_SLAVE2_PORT\"}]})"
REPLICA_SET_STATUS="rs.status()"
TLS_PARAMETRS_FOR_MONGO_SHELL="--tls --host 127.0.0.1 --port 27017 --tlsCertificateKeyFile /etc/ssl/mongodb.pem --tlsCAFile /etc/ssl/rootCA.pem --tlsAllowInvalidCertificates --tlsAllowInvalidHostnames"
echo -e "${CONFIG_REPLIC_SET}\\n${REPLICA_SET_STATUS}" | mongo ${TLS_PARAMETRS_FOR_MONGO_SHELL} >> ${OUTPUT_FILE} ${REDIRECT_STDERR_TO_STDOUT}
cat /etc/hosts >> ${OUTPUT_FILE} ${REDIRECT_STDERR_TO_STDOUT}
sleep 140
CLUSTER_ADMIN_AUTH="db.getSiblingDB(\"admin\").auth(\"config_user\", \"password2\")"
ADMIN_AUTH="db.getSiblingDB(\"admin\").auth(\"user_name\", \"password\")"
ADMIN_AUTH_FOR_MY_DB="db.getSiblingDB(\"admin\").auth(\"my_db_user\", \"password3\")"
DB_AUTH="db.auth(\"user_name\",\"password\")"
STEP_DOWN_COMMAND="rs.stepDown()"
sleep 5
echo -e "${ADMIN_AUTH}\\n${CLUSTER_ADMIN_AUTH}\\n${REPLICA_SET_STATUS}\\n${STEP_DOWN_COMMAND}\\n${REPLICA_SET_STATUS}" | mongo ${TLS_PARAMETRS_FOR_MONGO_SHELL} >> ${OUTPUT_FILE} ${REDIRECT_STDERR_TO_STDOUT}
sleep 5
echo -e "${CLUSTER_ADMIN_AUTH}\\n${REPLICA_SET_STATUS}" | mongo ${TLS_PARAMETRS_FOR_MONGO_SHELL} >> ${OUTPUT_FILE} ${REDIRECT_STDERR_TO_STDOUT}
sleep infinity
