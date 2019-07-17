echo "Envio a PC2"
key_1=`mpls nhlfe add key 0 instructions push gen 10003 \
	nexthop eth0 ipv4 16.0.0.4 | grep key | cut -d " " -f 4`

ip route add 14.0.0.0/24 via 16.0.0.4 mpls $key_1

echo "De vuelta"
mpls labelspace set dev eth0 labelspace 0
mpls ilm add label gen 20503 labelspace 0
