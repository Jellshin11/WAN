key1=`mpls nhlfe add key 0 instructions push gen 10001 \
	nexthop eth1 ipv4 12.0.0.2 | grep key | cut -d " " -f 4`  

ip route add 18.0.0.0/24 via 12.0.0.2 mpls $key1


mpls labelspace set dev eth1 labelspace 0

mpls ilm add label gen 10007 labelspace 0
