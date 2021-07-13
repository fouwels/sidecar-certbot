
# SPDX-FileCopyrightText: 2021 Kaelan Thijs Fouwels <kaelan.thijs@fouwels.com>
#
# SPDX-License-Identifier: MIT

FROM alpine:3.14.0

RUN apk add --no-cache openssl python3 augeas py3-pip py3-wheel py3-six py3-cryptography

RUN apk add --virtual .build musl-dev python3-dev libffi-dev openssl-dev cargo  && \
    pip3 --no-cache-dir install certbot && \
    apk del .build

COPY entrypoint.sh entrypoint.sh
RUN chmod +x ./entrypoint.sh

RUN addgroup -S certbot && adduser -S certbot -G certbot

RUN mkdir -p /etc/letsencrypt /var/log/letsencrypt /var/lib/letsencrypt /var/www/certbot
RUN chown -R certbot:certbot /etc/letsencrypt /var/log/letsencrypt /var/lib/letsencrypt /var/www/certbot

USER certbot
ENTRYPOINT ["./entrypoint.sh"]