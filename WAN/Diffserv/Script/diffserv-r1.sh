tc qdisc add dev eth0 handle ffff: ingress

#Ancho de banda para PC1
tc filter add dev eth0 parent ffff: protocol ip prio 1 u32 match ip src \
 11.0.0.10/32 police rate 1.2mbit burst 10k continue flowid :1

tc filter add dev eth0 parent ffff: protocol ip prio 1 u32 match ip src \
  11.0.0.10/24 police rate 600kbit burst 10k drop flowid :2

#Ancho de banda para pc2
tc filter add dev eth0 parent ffff:  protocol ip prio 1 u32 match ip src \
  11.0.0.11/24 police rate 300kbit burst 10k continue flowid :3

tc filter add dev eth0 parent ffff:  protocol ip prio 1 u32 match ip src \
  11.0.0.11/24 police rate 400kbit  burst 10k drop flowid :4

#DSMARK
tc qdisc add dev eth1 root handle 1:0 dsmark indices 8

#Calidad 1, descarte bajo
tc class change dev eth1 classid 1:1 dsmark mask 0x3 value 0x28
#Calidad 3, descarte alto
tc class change dev eth1 classid 1:2 dsmark mask 0x3 value 0x78
#Calidad 2, descarte bajo
tc class change dev eth1 classid 1:3 dsmark mask 0x3 value 0x48
#Calidad 4, descarte alto
tc class change dev eth1 classid 1:4 dsmark mask 0x3 value 0x98

tc filter add dev eth1 parent 1:0 protocol ip prio 1 \
	 handle 1 tcindex classid 1:1

tc filter add dev eth1 parent 1:0 protocol ip prio 1 \
	 handle 2 tcindex classid 1:2

tc filter add dev eth1 parent 1:0 protocol ip prio 1 \
	 handle 3 tcindex classid 1:3

tc filter add dev eth1 parent 1:0 protocol ip prio 1 \
	 handle 4 tcindex classid 1:4
