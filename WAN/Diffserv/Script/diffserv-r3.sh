tc qdisc add dev eth2 root handle 1:0 dsmark indices 8 set_tc_index

tc filter add dev eth2 parent 1:0 protocol ip prio 1 \
tcindex mask 0xfc shift 2

tc qdisc add dev eth2 parent 1:0 handle 2:0 htb

#Todos los flujos compartiran este ancho de banda
tc class add dev eth2 parent 2:0 classid 2:1 htb rate 2.4Mbit

#A Calidad 1 le corresponde 1MB
tc class add dev eth2 parent 2:1 classid 2:10 htb rate 1Mbit ceil 2.4Mbit

#A calidad 2 le corresponde 500kbit
tc class add dev eth2 parent 2:1 classid 2:20 htb rate 500kbit ceil 2.4Mbit

#A calidad 3 le corresponde 400kbit
tc class add dev eth2 parent 2:1 classid 2:30 htb rate 400kbit ceil 2.4Mbit

#A calidad 4 le corresponde 200kbit
tc class add dev eth2 parent 2:1 classid 2:40 htb rate 200kbit ceil 2.4Mbit

#Trafico AF11=> DS=0x28 = 00101000 => DSCP = 00 1010 = 0x0a
tc filter add dev eth2 parent 2:0 protocol ip prio 1 \
	handle 0x0a tcindex classid 2:10

#Trafico AF21=> DS=0x48 = 01001000 => DSCP = 01 0010 = 0x12
tc filter add dev eth2 parent 2:0 protocol ip prio 1 \
	handle 0x12 tcindex classid 2:20

#Trafico AF33=> DS=0x78 = 0111 1000 => DSCP 01 1110 = 0x1e
tc filter add dev eth2 parent 2:0 protocol ip prio 1 \
	handle 0x1e tcindex classid 2:30

#Trafico AF43=>DS=0x98 = 1001 1000 => DSCP 10 0110 = 0x26
tc filter add dev eth2 parent 2:0 protocol ip prio 1 \
	handle 0x26 tcindex classid 2:40
