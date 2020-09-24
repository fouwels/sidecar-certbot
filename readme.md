# nginx-sec

plug and play container for auto-tls'ing nginx via certbot.

Should be added to a stock nginx container architecture as per nginx.yml, 

Container will create dummy certificates, allow nginx to start, and then auto-request 90 day TLS certificates. Container will monitor and renew if required every 12 hours.

Unforunately, Nginx will need to be periodically externally reloaded as the certificates are renewed...
