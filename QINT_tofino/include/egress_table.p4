table tb_encoding_hop {
    key = {
        eg_md.meta.hop_latency : range; // last range is must be cover the max value
    }
    actions = {
		encoding_hop;
        NoAction();
	}
    const default_action = NoAction();
    size = 1024;
}

table tb_shift_hop1 {
    key = {
        hdr.qint_space.space_hop : exact;
        eg_md.meta.encoding_level_hop : exact;
    }
    actions = {
        shift_hop_1_1;
        shift_hop_1_2;
        shift_hop_1_3;
        shift_hop_1_4;
        shift_hop_1_5;
        shift_hop_1_6;
        shift_hop_1_7;
        shift_hop_1_8;
        shift_hop_1_9;
        shift_hop_1_10;
        shift_hop_1_11;
        shift_hop_1_12;
        shift_hop_1_13;
        shift_hop_1_14;
        shift_hop_1_15;
        shift_hop_1_16;
    }
    const entries = {
        (0x0, 1) : shift_hop_1_1();
        (0x0, 2) : shift_hop_1_2();
        (0x0, 3) : shift_hop_1_3();
        (0x0, 4) : shift_hop_1_4();
        (0x0, 5) : shift_hop_1_5();
        (0x0, 6) : shift_hop_1_6();
        (0x0, 7) : shift_hop_1_7();
        (0x0, 8) : shift_hop_1_8();
        (0x0, 9) : shift_hop_1_9();
        (0x0, 10) : shift_hop_1_10();
        (0x0, 11) : shift_hop_1_11();
        (0x0, 12) : shift_hop_1_12();
        (0x0, 13) : shift_hop_1_13();
        (0x0, 14) : shift_hop_1_14();
        (0x0, 15) : shift_hop_1_15();
        (0x0, 16) : shift_hop_1_16();
    }
}

table tb_shift_hop2 {
    key = {
        hdr.qint_space.space_hop : exact;
        eg_md.meta.encoding_level_hop : exact;
    }
    actions = {
        shift_hop_2_1;
        shift_hop_2_2;
        shift_hop_2_3;
        shift_hop_2_4;
        shift_hop_2_5;
        shift_hop_2_6;
        shift_hop_2_7;
        shift_hop_2_8;
        shift_hop_2_9;
        shift_hop_2_10;
        shift_hop_2_11;
        shift_hop_2_12;
        shift_hop_2_13;
        shift_hop_2_14;
        shift_hop_2_15;
        shift_hop_2_16;
    }
    const entries = {
        (0x1, 1) : shift_hop_2_1();
        (0x1, 2) : shift_hop_2_2();
        (0x1, 3) : shift_hop_2_3();
        (0x1, 4) : shift_hop_2_4();
        (0x1, 5) : shift_hop_2_5();
        (0x1, 6) : shift_hop_2_6();
        (0x1, 7) : shift_hop_2_7();
        (0x1, 8) : shift_hop_2_8();
        (0x1, 9) : shift_hop_2_9();
        (0x1, 10) : shift_hop_2_10();
        (0x1, 11) : shift_hop_2_11();
        (0x1, 12) : shift_hop_2_12();
        (0x1, 13) : shift_hop_2_13();
        (0x1, 14) : shift_hop_2_14();
        (0x1, 15) : shift_hop_2_15();
        (0x1, 16) : shift_hop_2_16();
    }
}

table tb_shift_hop3 {
    key = {
        hdr.qint_space.space_hop : exact;
        eg_md.meta.encoding_level_hop : exact;
    }
    actions = {
        shift_hop_3_1;
        shift_hop_3_2;
        shift_hop_3_3;
        shift_hop_3_4;
        shift_hop_3_5;
        shift_hop_3_6;
        shift_hop_3_7;
        shift_hop_3_8;
        shift_hop_3_9;
        shift_hop_3_10;
        shift_hop_3_11;
        shift_hop_3_12;
        shift_hop_3_13;
        shift_hop_3_14;
        shift_hop_3_15;
        shift_hop_3_16;
    }
    const entries = {
        (0x2, 1) : shift_hop_3_1();
        (0x2, 2) : shift_hop_3_2();
        (0x2, 3) : shift_hop_3_3();
        (0x2, 4) : shift_hop_3_4();
        (0x2, 5) : shift_hop_3_5();
        (0x2, 6) : shift_hop_3_6();
        (0x2, 7) : shift_hop_3_7();
        (0x2, 8) : shift_hop_3_8();
        (0x2, 9) : shift_hop_3_9();
        (0x2, 10) : shift_hop_3_10();
        (0x2, 11) : shift_hop_3_11();
        (0x2, 12) : shift_hop_3_12();
        (0x2, 13) : shift_hop_3_13();
        (0x2, 14) : shift_hop_3_14();
        (0x2, 15) : shift_hop_3_15();
        (0x2, 16) : shift_hop_3_16();
    }
}

table tb_shift_hop4 {
    key = {
        hdr.qint_space.space_hop : exact;
        eg_md.meta.encoding_level_hop : exact;
    }
    actions = {
        shift_hop_4_1;
        shift_hop_4_2;
        shift_hop_4_3;
        shift_hop_4_4;
        shift_hop_4_5;
        shift_hop_4_6;
        shift_hop_4_7;
        shift_hop_4_8;
        shift_hop_4_9;
        shift_hop_4_10;
        shift_hop_4_11;
        shift_hop_4_12;
        shift_hop_4_13;
        shift_hop_4_14;
        shift_hop_4_15;
        shift_hop_4_16;
    }
    const entries = {
        (0x3, 1) : shift_hop_4_1();
        (0x3, 2) : shift_hop_4_2();
        (0x3, 3) : shift_hop_4_3();
        (0x3, 4) : shift_hop_4_4();
        (0x3, 5) : shift_hop_4_5();
        (0x3, 6) : shift_hop_4_6();
        (0x3, 7) : shift_hop_4_7();
        (0x3, 8) : shift_hop_4_8();
        (0x3, 9) : shift_hop_4_9();
        (0x3, 10) : shift_hop_4_10();
        (0x3, 11) : shift_hop_4_11();
        (0x3, 12) : shift_hop_4_12();
        (0x3, 13) : shift_hop_4_13();
        (0x3, 14) : shift_hop_4_14();
        (0x3, 15) : shift_hop_4_15();
        (0x3, 16) : shift_hop_4_16();
    }
}
table tb_set_index_hop {
    key = {
        hdr.qint_space.space_hop : exact;
    }
    actions = {
        set_hop_1;
        set_hop_2;
        set_hop_3;
        set_hop_4;
    }
    const entries = {
        (0x0) : set_hop_1();
        (0x1) : set_hop_2();   
        (0x2) : set_hop_3();   
        (0x3) : set_hop_4();   
    }
    size = 4;
}

