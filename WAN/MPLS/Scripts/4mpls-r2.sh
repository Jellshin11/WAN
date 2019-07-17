#Entrada al tunel
mpls labelspace set dev eth0 labelspace 0
mpls ilm add label gen 10001 labelspace 0

key_1=`mpls nhlfe add key 0 instructions push gen 20001 \
	nexthop eth1 ipv4 13.0.0.3 | grep key | cut -d " " -f 4`

key_2=`mpls nhlfe add key 0 instructions push gen 10002 \
	forward $key_1 | grep key | cut -d " " -f 4`
	 
mpls xc add ilm_label gen 10001 ilm_labelspace 0 nhlfe_key $key_2

#Envio de pc2 a pc1 
mpls labelspace set dev eth1 labelspace 0
mpls ilm add label gen 10005 labelspace 0
mpls ilm add label gen 40002 labelspace 0
mpls ilm add label gen 50002 labelspace 0
mpls ilm add label gen 90002 labelspace 0


key_3=`mpls nhlfe add key 0 instructions push gen 10006 \
	nexthop eth0 ipv4 12.0.0.1 | grep key | cut -d " " -f 4`

mpls xc add ilm_label gen 10006 ilm_labelspace 0 nhlfe_key $key_3
mpls xc add ilm_label gen 40002 ilm_labelspace 0 nhlfe_key $key_3

#Envio de pc3 a pc2 por tunel
key_4=`mpls nhlfe add key 0 instructions push gen 70001 \
	nexthop eth1 ipv4 13.0.0.3 | grep key | cut -d " " -f 4`

key_5=`mpls nhlfe add key 0 instructions push gen 60001 \
	forward $key_4 | grep key | cut -d " " -f 4`

ip route add 17.0.0.0/24 via 13.0.0.3 mpls $key_5


#pc3
mpls labelspace set dev eth0 labelspace 0
mpls ilm add label gen 20003 labelspace 0
