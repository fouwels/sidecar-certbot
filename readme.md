<!--
SPDX-FileCopyrightText: 2021 Kaelan Thijs Fouwels <kaelan.thijs@fouwels.com>

SPDX-License-Identifier: MIT
-->

# certbot

Sidecar container for automatically tls'ing nginx via certbot.

Should be added to an upstream nginx container architecture as per `compose.yml`, 

Container will create dummy certificates on launch, allow nginx to start, and then request a 90 day letsencrypt ACME cert. Container should be perioidally triggered as a daemon to check and renew (if required)

Fake, followed by real certificates will be placed in `/keys`

Using upstream nginx, nginx will need to be periodically externally reloaded as the certificates are renewed...

Environment variables
- `EMAIL: "kaelan@fouwels.com" # Email to subscribe to letsencrypt`
- `DOMAINS: "-d testing.fouwels.app" # Specify additional certificate domains with the -d prefix included.`
- `STAGING: "--staging" # Enable to run certbot in staging (fake) cert mode, and prevent rate limiting if not publically accessible.`


# Licensing 

Defined via [SPDX](https://spdx.dev/)