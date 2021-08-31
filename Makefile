
# certbot# SPDX-FileCopyrightText: 2021 Kaelan Thijs Fouwels <kaelan.thijs@fouwels.com>
#
# SPDX-License-Identifier: MIT

COMPOSE=docker compose
STACKFILE= -f compose.yml

.PHONY: pull, up, up-d, down, down-v, logs

# Config
pull:
	$(COMPOSE) $(STACKFILE) pull
up: 
	$(COMPOSE) $(STACKFILE) up
up-d: 
	$(COMPOSE) $(STACKFILE) up -d
down:
	$(COMPOSE) $(STACKFILE) down
down-v:
	$(COMPOSE) $(STACKFILE) down -v
logs:
	$(COMPOSE) $(STACKFILE) logs -f
build:
	$(COMPOSE) $(STACKFILE) build
push:
	$(COMPOSE) $(STACKFILE) push