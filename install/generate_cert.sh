#!/bin/bash
echo "Generate CA cert"
openssl genrsa -passout pass:1234 -des3 -out ca.key 4096
openssl req -passin pass:1234 -new -x509 -days 365 -key ca.key -out ca.crt -subj  "/C=US/ST=CA/L=Sunnyvale/O=Sec/OU=SecOps/CN=Root CA"

echo "Generate Server cert"
openssl genrsa -passout pass:1234 -des3 -out server.key 4096
openssl req -passin pass:1234 -new -key server.key -out server.csr -subj  "/C=US/ST=CA/L=Sunnyvale/O=Sec/OU=Server/CN=localhost"
openssl x509 -req -passin pass:1234 -days 365 -in server.csr -CA ca.crt -CAkey ca.key -set_serial 01 -out server.crt

# remove passphrase
openssl rsa -passin pass:1234 -in server.key -out server.key

echo "Generate Client cert"
openssl genrsa -passout pass:1234 -des3 -out client.key 4096
openssl req -passin pass:1234 -new -key client.key -out client.csr -subj  "/C=US/ST=CA/L=Sunnyvale/O=Sec/OU=Client/CN=localhost"
openssl x509 -passin pass:1234 -req -days 365 -in client.csr -CA ca.crt -CAkey ca.key -set_serial 01 -out client.crt

# remove passphrase
openssl rsa -passin pass:1234 -in client.key -out client.key
