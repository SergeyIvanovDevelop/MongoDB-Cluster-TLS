#!/bin/bash
#This is comment

HOST="127.0.0.1"
PORT="27010"
TLS_KEY_FILE_AND_OWN_CA_SIGNED_SERTIFICATE="./mongodb.pem"
ROOT_CA_CERTIFICATE_FILE="./rootCA.pem"
COMMAND="mongo --tls --host ${HOST} --port ${PORT} --tlsCertificateKeyFile ${TLS_KEY_FILE_AND_OWN_CA_SIGNED_SERTIFICATE} --tlsCAFile ${ROOT_CA_CERTIFICATE_FILE} --tlsAllowInvalidCertificates --tlsAllowInvalidHostnames"
echo "COMMAND=${COMMAND}"
echo "Opening TLS connection with mongos ..."
${COMMAND}

