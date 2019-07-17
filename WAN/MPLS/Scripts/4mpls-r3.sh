mpls labelspace set dev eth0 labelspace 0
mpls ilm add label gen 10002 labelspace 0
mpls ilm add label gen 20001 labelspace 0
mpls ilm add label gen 30001 labelspace 0
mpls ilm add label gen 70001 labelspace 0

key_1=`mpls nhlfe add key 0 instructions push gen 10003 \
	nexthop eth1 ipv4 15.0.0.4 | grep key | cut -d " " -f 4`

key_2=`mpls nhlfe add key 0 instructions push gen 30002 \
	nexthop eth1 ipv4 15.0.0.4 | grep key | cut -d " " -f 4`

key_3=`mpls nhlfe add key 0 instructions push gen 20002 \
	nexthop eth1 ipv4 15.0.0.4 | grep key | cut -d " " -f 4`

#Reenvio
key_8=`mpls nhlfe add key 0 instructions push gen 70002 \
	nexthop eth1 ipv4 15.0.0.4 | grep key | cut -d " " -f 4`

mpls xc add ilm_label gen 10002 ilm_labelspace 0 nhlfe_key $key_1 
mpls xc add ilm_label gen 20001 ilm_labelspace 0 nhlfe_key $key_3 
mpls xc add ilm_label gen 30001 ilm_labelspace 0 nhlfe_key $key_2
mpls xc add ilm_label gen 70001 ilm_labelspace 0 nhlfe_key $key_8

mpls labelspace set dev eth1 labelspace 0
mpls ilm add label gen 10004 labelspace 0
mpls ilm add label gen 20002 labelspace 0
mpls ilm add label gen 50001 labelspace 0

key_3=`mpls nhlfe add key 0 instructions push gen 10005 \
	nexthop eth0 ipv4 13.0.0.2 | grep key | cut -d " " -f 4`

key_4=`mpls nhlfe add key 0 instructions push gen 20003 \
	nexthop eth0 ipv4 13.0.0.2 | grep key | cut -d " " -f 4`

key_5=`mpls nhlfe add key 0 instructions push gen 50002 \
	nexthop eth0 ipv4 13.0.0.2 | grep key | cut -d " " -f 4`

mpls xc add ilm_label gen 10005 ilm_labelspace 0 nhlfe_key $key_3 
mpls xc add ilm_label gen 20002 ilm_labelspace 0 nhlfe_key $key_4 
mpls xc add ilm_label gen 50001 ilm_labelspace 0 nhlfe_key $key_5



#Tunel pc3 a pc2
mpls labelspace set dev eth1 labelspace 0
mpls ilm add label gen 90001 labelspace 0

key_7=`mpls nhlfe add key 0 instructions push gen 90002 \
	nexthop eth0 ipv4 13.0.0.2 | grep key | cut -d " " -f 4`

mpls xc add ilm_label gen 90001 ilm_labelspace 0 nhlfe_key $key_7

