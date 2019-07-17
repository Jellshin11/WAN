tc qdisc add dev eth0 handle ffff: ingress

tc filter add dev eth0 parent ffff:  protocol ip prio 1 u32 match ip dst \
  192.168.3.60/32 police rate 400kbit burst 10k continue flowid :1

tc filter add dev eth0 parent ffff:  protocol ip prio 1 u32 match ip dst \
  192.168.3.60/32  police rate 300kbit burst 10k continue flowid :2

tc filter add dev eth0 parent ffff:  protocol ip prio 1 u32 match ip src \
  192.168.2.30/32 police rate 100kbit burst 10k drop flowid :3

tc qdisc add dev eth1 root handle 1:0 dsmark indices 4

#Calidad 2, descarte bajo
tc class change dev eth1 classid 1:1 dsmark mask 0x3 value 0x48
#Calidad 3, descarte bajo
tc class change dev eth1 classid 1:2 dsmark mask 0x3 value 0x68
#Calidad 4, descarte alto
tc class change dev eth1 classid 1:3 dsmark mask 0x3 value 0x98
 
tc filter add dev eth1 parent 1:0 protocol ip prio 1 \
	handle 1 tcindex classid 1:1

tc filter add dev eth1 parent 1:0 protocol ip prio 1 \
	handle 2 tcindex classid 1:2

tc filter add dev eth1 parent 1:0 protocol ip prio 1 \
	handle 3 tcindex classid 1:3
