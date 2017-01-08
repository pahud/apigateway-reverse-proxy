#!/bin/bash

SERVER_NAME='proxy.pahud.net'
BACKEND_SERVER_NAME='debug.pahud.net'

docker run -p 443:443 -d \
-e SERVER_NAME=$SERVER_NAME \
-e BACKEND_SERVER_NAME=$BACKEND_SERVER_NAME \
apigw-reverse-proxy
