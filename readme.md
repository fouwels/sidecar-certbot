# certbot

Sidecar container for automatically tls'ing nginx via certbot.

Should be added to an upstream nginx container architecture as per `nginx.yml`, 

Container will create dummy certificates on launch, allow nginx to start, and then request a 90 day letsencrypt TLS cert. Container will monitor and renew if required every 12 hours.

Unforunately, using upstream nginx, will need to be periodically externally reloaded as the certificates are renewed... to pick up the new config.

Environment variables
- `EMAIL: "kaelan@fouwels.com" # Email to subscribe to letsencrypt`
- `DOMAINS: "-d testing.fouwels.app" # Specify additional certificate domains with the -d prefix included.`
- `STAGING: "--staging" # Enable to run certbot in staging (fake) cert mode, and prevent rate limiting if not publically accessible.`
