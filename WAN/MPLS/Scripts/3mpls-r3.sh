echo "Envio de PC1,Pc3 a PC2"
mpls labelspace set dev eth0 labelspace 0
mpls ilm add label gen 10002 labelspace 0
mpls ilm add label gen 20001 labelspace 0
mpls ilm add label gen 20501 labelspace 0

key_1=`mpls nhlfe add key 0 instructions push gen 10003 \
	nexthop eth1 ipv4 15.0.0.4 | grep key | cut -d " " -f 4`

key_2=`mpls nhlfe add key 0 instructions push gen 20502 \
	nexthop eth1 ipv4 15.0.0.4 | grep key | cut -d " " -f 4`

mpls xc add ilm_label gen 10002 ilm_labelspace 0 nhlfe_key $key_1
mpls xc add ilm_label gen 20501 ilm_labelspace 0 nhlfe_key $key_2

echo "pc2 a pc1,pc3"
mpls labelspace set dev eth1 labelspace 0
mpls ilm add label gen 10004 labelspace 0
mpls ilm add label gen 20002 labelspace 0

key_3=`mpls nhlfe add key 0 instructions push gen 10005 \
	nexthop eth0 ipv4 13.0.0.2 | grep key | cut -d " " -f 4`

key_4=`mpls nhlfe add key 0 instructions push gen 10005 \
	nexthop eth0 ipv4 13.0.0.2 | grep key | cut -d " " -f 4`

mpls xc add ilm_label gen 10004 ilm_labelspace 0 nhlfe_key $key_2
mpls xc add ilm_label gen 20002 ilm_labelspace 0 nhlfe_key $key_3




