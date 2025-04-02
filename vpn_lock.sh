#!/bin/bash

VPN_IF="tun0"

if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root" >&2
    exit 1
fi

function get_vpn_ip() {
    ifconfig | grep -A 1 tun0 | grep inet | tr -s ' ' | cut -d ' ' -f 3
}

function lock_traffic() {
    VPN_SERVER_IP=$(get_vpn_ip)
    if [ -z "$VPN_SERVER_IP" ]; then
        echo "VPN interface $VPN_IF not found or has no IP" >&2
        exit 1
    fi

    iptables -F
    iptables -X
    iptables -t nat -F
    iptables -t nat -X
    iptables -P INPUT DROP
    iptables -P OUTPUT DROP
    iptables -P FORWARD DROP
    iptables -A INPUT -i lo -j ACCEPT
    iptables -A OUTPUT -o lo -j ACCEPT
    iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
    iptables -A OUTPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
    iptables -A OUTPUT -o $VPN_IF -j ACCEPT
    iptables -A INPUT -i $VPN_IF -j ACCEPT
    iptables -A OUTPUT -p udp --dport 53 -j ACCEPT
    iptables -A OUTPUT -p tcp --dport 53 -j ACCEPT
    iptables -A OUTPUT -d $VPN_SERVER_IP -j ACCEPT

    echo 1 > /etc/vpn_lock
    echo "Traffic restricted to VPN ($VPN_IF) only"
}

function unlock_traffic() {
    iptables -F
    iptables -X
    iptables -t nat -F
    iptables -t nat -X
    iptables -P INPUT ACCEPT
    iptables -P OUTPUT ACCEPT
    iptables -P FORWARD ACCEPT

    rm /etc/vpn_lock
    echo "Traffic restriction disabled"
}

function auto_traffic() {
  if [[ -f /etc/vpn_lock ]]; then
    unlock_traffic
  else
    lock_traffic
  fi
}

case "$1" in
    on) lock_traffic ;;
    off) unlock_traffic ;;
    help) echo "Usage: $0 {on|off|help}"; exit 1 ;;
    *) auto_traffic ;;
esac

exit 0
