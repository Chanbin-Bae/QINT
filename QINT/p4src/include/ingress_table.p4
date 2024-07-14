table tb_set_source {
	key = {
		hdr.ipv4.dscp : exact;
	}
	actions = {
		int_set_source;
		NoAction();
	}
	const default_action = NoAction();
}

table tb_set_switch_id {
	key = {
		hdr.ipv4.version : exact;
	}
	actions = {
		set_switch_id;
		NoAction();
	}
	const default_action = NoAction();
}

table tb_valid_space {
	actions = {
		valid_space();
		NoAction();
	}
	const default_action = valid_space();
}

table tb_forward {
	key = {
		hdr.ipv4.dstAddr : exact;
	}
	actions = {
		set_egress_port;
		NoAction;
	}
	const default_action = NoAction();
}