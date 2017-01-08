#!/bin/bash


proxy_server_conf='/etc/nginx/conf.d/proxy_server.conf'
sed -ie "s/%SERVER_NAME%/${SERVER_NAME-localhost}/g" $proxy_server_conf
sed -ie "s/%BACKEND_SERVER_NAME%/${BACKEND_SERVER_NAME-no.backend.name}/g" $proxy_server_conf

/usr/local/bin/supervisord -c /etc/supervisord.conf --nodaemon
