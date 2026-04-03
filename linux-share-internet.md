nmcli device status

nmcli con add type ethernet ifname enp1s0 con-name shared-local ipv4.method shared ipv6.method ignore

sudo nmcli connection up shared-local

sudo nft add rule ip filter FORWARD iifname <subnet adapter> accept
sudo nft add rule ip filter FORWARD ct state established,related accept

# enable tunnel
resolvectl # to find tunnel's DNS server
# set client's DNS to thet tunnel's DNS IP, this bypasses the tunnel's dport 53 (DNS) filtering policy
# it uses the FORWARD chain instead of the INPUT chain
# also works just to use the gateway IP of the subnet, easier, this is usually the default for client machines
#     on the subnet (like macs), just remove explicit DNS entries and the subnet gateway will be in the DNS server
#	perhaps grayed out

# server uses nft?
sudo nft list ruleset
sudo nft -a list ruleset # shows handle numbers

# tunnels often add rules to filter out dport 53 (to avoid DNS leaks)
