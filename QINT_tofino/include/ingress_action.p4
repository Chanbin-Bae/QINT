action int_set_source () {
	ig_md.meta.source = true;
	hdr.ipv4.dscp = INT;
}	

action set_switch_id(bit<32> switch_id){
	ig_md.meta.switch_id = switch_id;
}

action set_egress_port(bit<9> port) {
	ig_tm_md.ucast_egress_port = port;
	hdr.ipv4.ttl=hdr.ipv4.ttl-1;
}
