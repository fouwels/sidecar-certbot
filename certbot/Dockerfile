# SPDX-FileCopyrightText: 2021 Kaelan Thijs Fouwels <kaelan.thijs@fouwels.com>
#
# SPDX-License-Identifier: MIT

FROM alpine:3.14.0

RUN apk add --no-cache openssl certbot

COPY entrypoint.sh entrypoint.sh
RUN chmod +x ./entrypoint.sh

RUN addgroup -S certbot && adduser -S certbot -G certbot

RUN mkdir -p /etc/letsencrypt /var/log/letsencrypt /var/lib/letsencrypt /var/www/certbot
RUN chown -R certbot:certbot /etc/letsencrypt /var/log/letsencrypt /var/lib/letsencrypt /var/www/certbot

USER certbot
ENTRYPOINT ["./entrypoint.sh"]