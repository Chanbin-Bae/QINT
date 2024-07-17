action int_set_source () {
	ig_md.meta.source = true;
	hdr.ipv4.dscp = INT;
}	

action set_switch_id(bit<32> switch_id){
	ig_md.meta.switch_id = switch_id;
}

// action valid_space() {
// 	hdr.qint_info_q.setValid(); // 1
// 	hdr.qint_info_hop.setValid(); // 1
// 	hdr.qint_q_1.setValid(); // 4
// 	hdr.qint_hop_1.setValid(); // 4
// 	hdr.int_length.setValid(); // 4
// 	hdr.ipv4.totalLen = hdr.ipv4.totalLen + 14;
// }

action set_egress_port(bit<9> port) {
	ig_tm_md.ucast_egress_port = port;
	hdr.ipv4.ttl=hdr.ipv4.ttl-1;
}
