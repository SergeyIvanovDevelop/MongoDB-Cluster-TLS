#!/bin/bash
#This is comment

# ====================== mongod.conf BEGIN ====================================

EDITED_FILE="/etc/mongod.conf"
NUMBER_REPLACE="1"
REPLIC_SET_NAME=' \"config\"'
CLUSTER_ROLE=' configsvr'
SED_COMMAND="sed -E -i"

#1 
# =============================================================================
# =============================================================================
SEARCH_STRING="#replication:"
REPLACE_STRING="replication:\n  replSetName:${REPLIC_SET_NAME}"
COMMAND_FOR_SED="s/${SEARCH_STRING}/${REPLACE_STRING}/${NUMBER_REPLACE}"
${SED_COMMAND} "${COMMAND_FOR_SED}" ${EDITED_FILE}
# =============================================================================
# =============================================================================

#2 
# =============================================================================
# =============================================================================
SEARCH_STRING="#sharding:"
REPLACE_STRING="sharding:\n  clusterRole:${CLUSTER_ROLE}"
COMMAND_FOR_SED="s/${SEARCH_STRING}/${REPLACE_STRING}/${NUMBER_REPLACE}"
${SED_COMMAND} "${COMMAND_FOR_SED}" ${EDITED_FILE}
# =============================================================================
# =============================================================================

#3 
# =============================================================================
# =============================================================================
SEARCH_STRING="bindIp: 127.0.0.1"
REPLACE_STRING="bindIp: 0.0.0.0\n  tls:\n    mode: requireTLS\n    certificateKeyFile: /etc/ssl/mongodb.pem\n    CAFile: /etc/ssl/rootCA.pem\n    disabledProtocols: TLS1_0,TLS1_1\n    allowInvalidCertificates: true\n    allowInvalidHostnames: true\n    allowConnectionsWithoutCertificates: true"
COMMAND_FOR_SED="s|${SEARCH_STRING}|${REPLACE_STRING}|${NUMBER_REPLACE}"
${SED_COMMAND} "${COMMAND_FOR_SED}" ${EDITED_FILE}
# =============================================================================
# =============================================================================

#4 
# =============================================================================
# =============================================================================
SEARCH_STRING="#security:"
REPLACE_STRING="security:\n  keyFile: /mongo_cfg_server/auth_keyfile_for_cluster.key\n  #transitionToAuth: true"
COMMAND_FOR_SED="s|${SEARCH_STRING}|${REPLACE_STRING}|${NUMBER_REPLACE}"
${SED_COMMAND} "${COMMAND_FOR_SED}" ${EDITED_FILE}
# =============================================================================
# =============================================================================

# ====================== mongod.conf END ======================================
