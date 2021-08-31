# SPDX-FileCopyrightText: 2021 Kaelan Thijs Fouwels <kaelan.thijs@fouwels.com>
#
# SPDX-License-Identifier: MIT

FROM alpine:3.14.1

RUN apk add --no-cache openssl openssl-dev certbot

COPY entrypoint.sh entrypoint.sh
RUN chmod +x ./entrypoint.sh

RUN addgroup -S certbot && adduser -S certbot -G certbot

RUN mkdir -p /etc/letsencrypt /var/log/letsencrypt /var/lib/letsencrypt /var/www/certbot /keys
RUN chown -R certbot:certbot /etc/letsencrypt /var/log/letsencrypt /var/lib/letsencrypt /var/www/certbot /keys

USER certbot
ENTRYPOINT ["./entrypoint.sh"]