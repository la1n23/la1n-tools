#!/bin/bash
sudo bash -c "cat /home/$(whoami)/openconnect | openconnect --user $VPN_USER --servercert pin-sha256:$VPN_CERT_HASH --passwd-on-stdin $VPN_DOMAIN:$VPN_PORT"
