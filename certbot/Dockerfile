FROM certbot/certbot:v1.17.0

RUN apk add --no-cache openssl

COPY entrypoint.sh entrypoint.sh
RUN chmod +x ./entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]