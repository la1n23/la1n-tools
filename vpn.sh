#!/bin/bash
op=$(which openconnect)
while true; do cat ~/openconnect | sudo $op --reconnect-timeout=5 --user $VPN_USER --servercert pin-sha256:$VPN_CERT_HASH --passwd-on-stdin $VPN_DOMAIN:$VPN_PORT; sleep 0.1; done
