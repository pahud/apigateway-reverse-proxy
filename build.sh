#!/bin/bash

PRIVATE_KEY="./ssl/proxy.pahud.net/privatekey.pem"
CERT="./ssl/proxy.pahud.net/fullchain.pem"
CLIENT_CERT="./client_cert.crt"
image_tag='apigw-reverse-proxy'
dockerfile='Dockerfile'

docker build \
--build-arg PRIVATE_KEY=$PRIVATE_KEY \
--build-arg CERT=$CERT \
--build-arg CLIENT_CERT=$CLIENT_CERT \
-t $image_tag . -f $dockerfile
