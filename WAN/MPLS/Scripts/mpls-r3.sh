echo "Envio de PC1 a PC2"
mpls labelspace set dev eth0 labelspace 0
mpls ilm add label gen 10002 labelspace 0

key_1=`mpls nhlfe add key 0 instructions push gen 10003 \
	nexthop eth1 ipv4 15.0.0.4 | grep key | cut -d " " -f 4`

mpls xc add ilm_label gen 10002 ilm_labelspace 0 nhlfe_key $key_1


echo "pc2 a pc1"
mpls labelspace set dev eth1 labelspace 0
mpls ilm add label gen 10004 labelspace 0

key_1=`mpls nhlfe add key 0 instructions push gen 10005 \
	nexthop eth0 ipv4 13.0.0.2 | grep key | cut -d " " -f 4`

mpls xc add ilm_label gen 10004 ilm_labelspace 0 nhlfe_key $key_1

