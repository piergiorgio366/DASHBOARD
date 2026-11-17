FROM nginx:1.27-alpine

RUN apk add --no-cache apache2-utils
COPY default.conf.template /etc/nginx/templates/default.conf.template
COPY 20-create-auth-file.sh /docker-entrypoint.d/20-create-auth-file.sh
RUN chmod 755 /docker-entrypoint.d/20-create-auth-file.sh

EXPOSE 10000
