import ipaddress

def generate_ip_range(network):
    """Generate all IPs in a given network range."""
    return [str(ip) for ip in ipaddress.IPv4Network(network, strict=False)]

def generate_ipv6_range(network):
    """Generate all IPs in a given IPv6 network range."""
    return [str(ip) for ip in ipaddress.IPv6Network(network, strict=False)]

def main():
    # IPv4 ranges
    ipv4_ranges = [
        "192.168.0.0/24",
        #"192.168.0.0/16",
        #"10.0.0.0/8",
        #"172.16.0.0/12",
        #"127.0.0.0/8",
        #"169.254.0.0/16",
        #"0.0.0.0/8",
        #"192.0.0.0/24",
        #"192.0.2.0/24",
        #"198.51.100.0/24",
        #"203.0.113.0/24",
    ]

    # IPv6 ranges
    ipv6_ranges = [
        #"::1/128",
        #"fc00::/7",
        #"fe80::/10",
    ]

    # Localhost variants
    localhost_variants = [
        "localhost",
        "local",
        "127.0.0.1",
        "127.0.0.2",
        "127.1.0.1",
        "127.255.255.255",
        "::1",
        "0:0:0:0:0:0:0:1",
        "localhost.localdomain",
        "localhost6",
        "localhost6.localdomain6",
    ]

    # Generate all IPs
    all_ips = []
    for network in ipv4_ranges:
        all_ips.extend(generate_ip_range(network))
    for network in ipv6_ranges:
        all_ips.extend(generate_ipv6_range(network))
    all_ips.extend(localhost_variants)

    # Write to file
    with open("ssrf_wordlist.txt", "w") as f:
        for ip in all_ips:
            f.write(f"{ip}\n")

    print(f"Generated {len(all_ips)} entries in ssrf_wordlist.txt")

if __name__ == "__main__":
    main()
