action int_set_source () {
	meta.source = true;
	hdr.ipv4.dscp = INT;
	hdr.ipv4.totalLen = hdr.ipv4.totalLen + 4;
}	

action set_switch_id(bit<32> switch_id){
	meta.switch_id = switch_id;
}

action valid_space() {
	hdr.qint_info.setValid(); // 1
	hdr.qint_hop_1.setValid(); // 4
	hdr.ipv4.totalLen = hdr.ipv4.totalLen + 5;
}

action set_egress_port(bit<9> port) {
	standard_metadata.egress_spec = port;
	hdr.ipv4.ttl=hdr.ipv4.ttl-1;
}
