#!/bin/ash
# SPDX-FileCopyrightText: 2021 Kaelan Thijs Fouwels <kaelan.thijs@fouwels.com>
#
# SPDX-License-Identifier: MIT

set -e

if [ -z "$EMAIL" ]; then
    echo "Error, EMAIL environment variable not supplied"
fi
if [ -z "$DOMAINS" ]; then
    echo "Error, DOMAINS environment variable not supplied"
fi

CERTNAME=master
PATH="/etc/letsencrypt/live/$CERTNAME"
/bin/mkdir -p $PATH

if [ ! -f "$PATH/fullchain.pem" ]; then
    echo "> $PATH/fullchain.pem does not exist, initializing certbot"

    echo "> Creating dummy certificates in $PATH"
    /usr/bin/openssl req -x509 -nodes -newkey rsa:3072 -days 1 -keyout "$PATH/privkey.pem" -out "$PATH/fullchain.pem" -subj '/CN=localhost'

    echo "> Initial provisioning, so sleeping 10s to allow NGINX to start"
    /bin/sleep 10s

    echo "> Removing dummy certificates from $PATH"
    /bin/rm -rf $PATH

    echo "> Requesting TLS certificates into $PATH"
    /usr/bin/certbot certonly $STAGING --keep-until-expiring --rsa-key-size 3072 --webroot -w /var/www/certbot --email $EMAIL --agree-tos --non-interactive --cert-name $CERTNAME $DOMAINS

else
    echo "> $PATH exists, skipping certbot initialization"
fi

exec "$@"
