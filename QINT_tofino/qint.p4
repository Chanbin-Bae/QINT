/* -*- P4_16 -*- */
#include <core.p4>
#include <tna.p4>


#define INT 20 //FAT_INT
const bit<16> TYPE_IPV4 = 0x800;

#include "include/header.p4"
#include "include/parser.p4"

control SwitchIngress(inout headers hdr, 
		      inout ingress_metadata_t ig_md, 
		      in ingress_intrinsic_metadata_t ig_intr_md, 
		      in ingress_intrinsic_metadata_from_parser_t ig_prsr_md, 
		      inout ingress_intrinsic_metadata_for_deparser_t ig_dprsr_md, 
		      inout ingress_intrinsic_metadata_for_tm_t ig_tm_md) {

	#include "include/ingress_action.p4"
	#include "include/ingress_table.p4"

	apply{
		
		tb_set_source.apply();
		tb_set_switch_id.apply();

		hdr.local_report_header.setValid();
		hdr.local_report_header.ingress_port_id = (bit<16>) ig_intr_md.ingress_port;
		hdr.local_report_header.queue_id = (bit<8>) ig_tm_md.qid;
		hdr.local_report_header.ingress_global_tstamp = (bit<64>) ig_intr_md.ingress_mac_tstamp;

		if (ig_md.meta.source == true){
			// tb_valid_space.apply();
			// hdr.qint_info_hop.setValid(); // 1
			hdr.qint_num.setValid();
			hdr.qint_space.setValid();
			hdr.qint_hop_1.setValid(); // 4
		}

		tb_forward.apply();		
	}
}

control SwitchEgress(inout headers hdr, 
		     inout egress_metadata_t eg_md, 
 		     in egress_intrinsic_metadata_t eg_intr_md, 
		     in egress_intrinsic_metadata_from_parser_t eg_prsr_md, 
		     inout egress_intrinsic_metadata_for_deparser_t eg_dprsr_md, 
		     inout egress_intrinsic_metadata_for_output_port_t eg_oport_md) {
		
	bit<32> encoding_bit_hop;
	
	

	#include "include/register.p4"
	#include "include/egress_action.p4"
	#include "include/egress_table.p4"

	apply {
        eg_md.meta.check_hop = false;
        eg_md.meta.check_space_hop = false;
		
		eg_md.meta.hop_latency = (bit<19>) ( (bit<64>) eg_prsr_md.global_tstamp - hdr.local_report_header.ingress_global_tstamp);

		tb_encoding_hop.apply();
		check_encoding_bit_hop();
		
		hdr.qint_num.num_hop = hdr.qint_num.num_hop + eg_md.meta.encoding_level_hop;

		if (hdr.qint_num.num_hop > 32){
			reset_num_hop();
			update_space_hop();
    	}

        if (eg_md.meta.check_space_hop && (hdr.qint_space.space_hop == 1)){
            hdr.qint_hop_2.setValid();
        }
		if (eg_md.meta.check_space_hop && (hdr.qint_space.space_hop == 2)){
            hdr.qint_hop_3.setValid();
        }
		if (eg_md.meta.check_space_hop && (hdr.qint_space.space_hop == 3)){
            hdr.qint_hop_4.setValid();
        }
		

	tb_shift_hop1.apply();
	tb_shift_hop2.apply();
	tb_shift_hop3.apply();
	tb_shift_hop4.apply();

        tb_set_index_hop.apply(); // stack encoded bits 		
	}
}

Pipeline(SwitchIngressParser(),
	SwitchIngress(),
	SwitchIngressDeparser(),
	SwitchEgressParser(),
	SwitchEgress(),
	SwitchEgressDeparser()
) pipe;

Switch(pipe) main;
