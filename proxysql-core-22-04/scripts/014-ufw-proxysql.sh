#!/bin/sh

sed -e 's|DEFAULT_FORWARD_POLICY=.*|DEFAULT_FORWARD_POLICY="ACCEPT"|g' \
    -i /etc/default/ufw

ufw limit ssh

# 1-Click uses default proxySQL ports:
# - 6033 - incoming mysql connections
# - 6070 - prometheus metrics endpoint (disabled by default)
# - 6080 - admin UI (disabled by default)

ufw allow 6033/tcp
ufw allow 6070/tcp
ufw allow 6080/tcp

ufw --force enable
