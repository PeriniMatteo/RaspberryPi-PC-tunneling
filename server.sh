#!/bin/bash

pub_int="wlp2s0"
prv_int="enp1s0f1"

echo 1 > /proc/sys/net/ipv4/ip_forward

iptables -X
iptables -F
iptables -t nat -X
iptables -t nat -F


iptables -t nat -A POSTROUTING -o $pub_int -j MASQUERADE
iptables -A FORWARD -i $pub_int -o $prv_int -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -i $prv_int -o $pub_int -j ACCEPT

route add -net default gw 192.168.0.1 netmask 0.0.0.0 dev wlp2s0 metric 1
