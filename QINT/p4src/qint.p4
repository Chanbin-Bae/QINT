/* -*- P4_16 -*- */
#include <core.p4>
#include <v1model.p4>

#define INT 0x8 

#include "include/header.p4"
#include "include/parser.p4"

control MyVerifyChecksum(inout headers hdr, inout metadata meta) {
    apply {  }
}

control MyIngress(inout headers hdr,
		  inout metadata meta,
		  inout standard_metadata_t standard_metadata) {

	#include "include/ingress_action.p4"
	#include "include/ingress_table.p4"

	apply {		
		tb_set_source.apply();
		tb_set_switch_id.apply();
		if (meta.source == true){
		    tb_valid_space.apply();
		}
		tb_forward.apply();				
	}
}

control MyEgress(inout headers hdr,
		 inout metadata meta,
		 inout standard_metadata_t standard_metadata) {
	
	register<bit<32>>(40000) encoding_info_hop;
	bit<32> encoding_bit_hop;
	bit<32> encoding_level_hop;
	
	#include "include/egress_action.p4"
	#include "include/egress_table.p4"

	apply {
        meta.check_hop = false;
        meta.check_space_hop = false;

	tb_encoding_hop.apply();

        if (meta.check_space_hop && hdr.qint_info.hop_space == 1){
            hdr.qint_hop_2.setValid();
	    hdr.ipv4.totalLen = hdr.ipv4.totalLen + 4;
        }
        if (meta.check_space_hop && hdr.qint_info.hop_space == 2){
            hdr.qint_hop_3.setValid();
	    hdr.ipv4.totalLen = hdr.ipv4.totalLen + 4;
        }
	if (meta.check_space_hop && hdr.qint_info.hop_space == 3){
            hdr.qint_hop_4.setValid();
	    hdr.ipv4.totalLen = hdr.ipv4.totalLen + 4;
        }
	meta.space_hop = hdr.qint_info.hop_space;

        tb_set_index_hop.apply(); // stack encoded bits 
	}
}

control MyComputeChecksum(inout headers hdr, inout metadata meta) {
	apply {		}
}

V1Switch(
		MyParser(),
		MyVerifyChecksum(),
		MyIngress(),
		MyEgress(),
		MyComputeChecksum(),
		MyDeparser()
) main;
