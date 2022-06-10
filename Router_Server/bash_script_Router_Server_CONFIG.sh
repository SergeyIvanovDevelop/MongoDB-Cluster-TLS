#!/bin/bash
#This is comment

# ====================== mongod.conf BEGIN ====================================

EDITED_FILE="/etc/mongod.conf"
NUMBER_REPLACE="1"
SED_COMMAND="sed -E -i"

#1
# =============================================================================
# =============================================================================
SEARCH_STRING="bindIp: 127.0.0.1"
REPLACE_STRING="bindIp: 0.0.0.0\n  tls:\n    mode: requireTLS\n    certificateKeyFile: /etc/ssl/mongodb.pem\n    CAFile: /etc/ssl/rootCA.pem\n    disabledProtocols: TLS1_0,TLS1_1\n    allowInvalidCertificates: true\n    allowInvalidHostnames: true\n    allowConnectionsWithoutCertificates: true"
COMMAND_FOR_SED="s|${SEARCH_STRING}|${REPLACE_STRING}|${NUMBER_REPLACE}"
${SED_COMMAND} "${COMMAND_FOR_SED}" ${EDITED_FILE}
# =============================================================================
# =============================================================================

#2 
# =============================================================================
# =============================================================================
SEARCH_STRING="#security:"
REPLACE_STRING="security:\n  keyFile: /mongo_router_server/auth_keyfile_for_cluster.key\n  #transitionToAuth: true"
COMMAND_FOR_SED="s|${SEARCH_STRING}|${REPLACE_STRING}|${NUMBER_REPLACE}"
${SED_COMMAND} "${COMMAND_FOR_SED}" ${EDITED_FILE}
# =============================================================================
# =============================================================================

# ====================== mongod.conf END ======================================
