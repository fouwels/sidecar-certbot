#!/bin/ash
set -e

if [ -z "$EMAIL" ]; then
    echo "Error, EMAIL environment variable not supplied"
fi
if [ -z "$DOMAINS" ]; then
    echo "Error, DOMAINS environment variable not supplied"
fi

CERTNAME=master
PATH="/etc/letsencrypt/live/$CERTNAME"

if [ ! -d "$PATH" ]; then
    echo "> $PATH does not exist, initializing certbot"

    echo "> Creating dummy certificates in $PATH"
    /bin/mkdir -p $PATH
    /usr/bin/openssl req -x509 -nodes -newkey rsa:2048 -days 1 -keyout "$PATH/privkey.pem" -out "$PATH/fullchain.pem" -subj '/CN=localhost'

    echo "> Sleeping 10s to allow NGINX to start"
    /bin/sleep 10s

    echo "> Removing dummy certificates from $PATH"
    /bin/rm -rf $PATH

    echo "> Requesting TLS certificates into $PATH"
    /usr/bin/certbot certonly $STAGING --keep-until-expiring --rsa-key-size 3076 --webroot -w /var/www/certbot --email $EMAIL --agree-tos --non-interactive --cert-name $CERTNAME $DOMAINS

else
    echo "> $PATH exists, skipping certbot initialization"
fi

exec "$@"
