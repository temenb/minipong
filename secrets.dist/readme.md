#jwtRS256.key
#jwtRS256.key.pub

openssl genrsa -out jwtRS256.key 2048
openssl rsa -in jwtRS256.key -pubout -out jwtRS256.key.pub


