echo "Envio de PC1 a PC2"
mpls labelspace set dev eth0 labelspace 1
mpls ilm add label gen 10003 labelspace 1
mpls ilm add label gen 20502 labelspace 1

mpls labelspace set dev eth1 labelspace 1
mpls ilm add label gen 10003 labelspace 1

echo "pc2 a pc1,pc3"
key_1=`mpls nhlfe add key 0 instructions push gen 10004 \
	nexthop eth0 ipv4 15.0.0.3 | grep key | cut -d " " -f 4`


key_2=`mpls nhlfe add key 0 instructions push gen 20002 \
	nexthop eth0 ipv4 15.0.0.3 | grep key | cut -d " " -f 4`


ip route add 11.0.0.0/24 via 15.0.0.3 mpls $key_1 
ip route add 14.0.0.0/24 via 15.0.0.3 mpls $key_2

key_3=`mpls nhlfe add key 0 instructions push gen 20503 \
	nexthop eth1 ipv4 16.0.0.5 | grep key | cut -d " " -f 4`

mpls xc add ilm_label gen 20502 ilm_labelspace 1 nhlfe_key $key_3
mpls xc add ilm_label gen 10003 ilm_labelspace 1 nhlfe_key $key_2
