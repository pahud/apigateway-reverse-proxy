FROM amazonlinux:latest
#FROM pahud/amazonlinux

ENV SERVER_NAME proxy.pahud.net
ENV BACKEND_SERVER_NAME debug.pahud.net

ARG PRIVATE_KEY=./ssl/proxy.pahud.net/privatekey.pem
ARG CERT=./ssl/proxy.pahud.net/fullchain.pem
ARG CLIENT_CERT=./client_cert.crt

ADD $PRIVATE_KEY /etc/nginx/conf/ssl/privatekey.pem
ADD $CERT /etc/nginx/conf/ssl/fullchain.pem
ADD $CLIENT_CERT /etc/nginx/conf/ssl/client.crt

RUN yum update -y && \
yum install nginx python-pip -y && \
easy_install-2.6 supervisor && \
echo_supervisord_conf > /etc/supervisord.conf && \
mkdir -p /etc/supervisor/conf.d /var/log/supervisor

ADD ./startup.sh /
ADD ./nginx.conf.skeleton /etc/nginx/conf.d/proxy_server.conf

RUN echo $'[program:nginx]\n\
command=/usr/sbin/nginx -g "daemon off;"\n\
stdout_logfile=/var/log/supervisor/%(program_name)s.log\n\
stderr_logfile=/var/log/supervisor/%(program_name)s.log\n\
autorestart=true\n'\
>> /etc/supervisor/conf.d/nginx.conf


RUN echo $'[include]\n\
files = /etc/supervisor/conf.d/*.conf\n'\ 
>> /etc/supervisord.conf


EXPOSE 80 443

CMD ["/startup.sh"]
