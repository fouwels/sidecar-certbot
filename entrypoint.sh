#!/bin/ash
# SPDX-FileCopyrightText: 2021 Kaelan Thijs Fouwels <kaelan.thijs@fouwels.com>
#
# SPDX-License-Identifier: MIT

set -e

if [ -z "$EMAIL" ]; then
    echo "> Error, EMAIL environment variable not supplied"
fi
if [ -z "$DOMAINS" ]; then
    echo "> Error, DOMAINS environment variable not supplied"
fi

CERTNAME=master
PATH="/etc/letsencrypt/live/$CERTNAME"
OUTPUT="/keys"
/bin/chmod 777 $OUTPUT

if [ ! -f "$OUTPUT/fullchain.pem" ]; then
    echo "> $OUTPUT/fullchain.pem does not exist, creating dummy certificates"

    echo "> Creating dummy certificates in $OUTPUT"
    /usr/bin/openssl req -x509 -nodes -newkey rsa:3072 -days 1 -keyout "$OUTPUT/privkey.pem" -out "$OUTPUT/fullchain.pem" -subj '/CN=localhost'
    /bin/chmod -R 666 $OUTPUT/privkey.pem $OUTPUT/fullchain.pem

    echo "> Sleeping 10s to allow NGINX to start"
    /bin/sleep 10s

else
    echo "> $PATH exists, skipping dummy certificate initialization"
fi

echo "> Requesting TLS certificates into $PATH"
/usr/bin/certbot certonly $STAGING --keep-until-expiring --rsa-key-size 3072 --webroot -w /var/www/certbot --email $EMAIL --agree-tos --non-interactive --cert-name $CERTNAME $DOMAINS --deploy-hook "/bin/cp -f $PATH/privkey.pem $OUTPUT && /bin/cp -f $PATH/fullchain.pem $OUTPUT && /bin/chmod 666 $OUTPUT/privkey.pem $OUTPUT/fullchain.pem"

exec "$@"
