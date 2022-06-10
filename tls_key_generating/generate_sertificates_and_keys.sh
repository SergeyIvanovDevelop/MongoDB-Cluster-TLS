openssl genrsa -out rootCA.key 2048
openssl rsa -in rootCA.key -pubout -out rootCA_public.key
COUNTRY_NAME="AU"
PROVINCE_NAME="PROVINCE_NAME"
CITY="CITY"
ORGANIZATION_NAME="ORGANIZATION_NAME"
ORGANIZATION_UNIT_NAME="ORGANIZATION_UNIT_NAME"
COMMON_NAME="127.0.0.1"
EMAIL_ADDRESS="EMAIL_ADDRESS"
CHALLANGE_PASSWORD="\n"
OPTIONAL_COMAPNY_NAME="\n"
echo -e "${COUNTRY_NAME}\\n${PROVINCE_NAME}\\n${CITY}\\n${ORGANIZATION_NAME}\\n${ORGANIZATION_UNIT_NAME}\\n${COMMON_NAME}\\n${EMAIL_ADDRESS}" | openssl req -x509 -new -nodes -key rootCA.key -sha256 -days 1024 -out rootCA.pem
openssl genrsa -out mongodb.key 2048
openssl rsa -in mongodb.key -pubout -out mongodb_public.key
echo -e "${COUNTRY_NAME}\\n${PROVINCE_NAME}\\n${CITY}\\n${ORGANIZATION_NAME}\\n${ORGANIZATION_UNIT_NAME}\\n${COMMON_NAME}\\n${EMAIL_ADDRESS}\\n${CHALLANGE_PASSWORD}\\n${OPTIONAL_COMAPNY_NAME}" | openssl req -nodes -new -key mongodb.key -out mongodb.csr
echo -e "${COUNTRY_NAME}\\n${PROVINCE_NAME}\\n${CITY}\\n${ORGANIZATION_NAME}\\n${ORGANIZATION_UNIT_NAME}\\n${COMMON_NAME}\\n${EMAIL_ADDRESS}" | openssl x509 -req -extensions v3_ca -extfile ./ssl-extensions-x509.cnf -in mongodb.csr -CA rootCA.pem -CAkey rootCA.key -CAcreateserial -out mongodb.crt -days 500 -sha256
cat mongodb.key mongodb.crt > mongodb.pem
openssl verify -CAfile rootCA.pem mongodb_1.pem




