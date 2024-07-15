table tb_decision_hop {
    key = {
        meta.hop_latency : range;
    }
    actions = {
	encoding_hop;
        NoAction();
	}
    const default_action = NoAction();
    size = 40000;
}

table tb_insert_hop {
    key = {
        meta.space_hop : exact;
    }
    actions = {
        set_hop1;
        set_hop2;
        set_hop3;
        set_hop4;
    }
    const entries = {
        (0x0) : set_hop1();
        (0x1) : set_hop2();
        (0x2) : set_hop3();
        (0x3) : set_hop4();
    }
}

