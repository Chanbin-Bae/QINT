parser SwitchIngressParser(packet_in packet,
                           out headers hdr,
                           out ingress_metadata_t ig_md,
                           out ingress_intrinsic_metadata_t ig_intr_md) {

		state start {
				packet.extract(hdr.ethernet);
				packet.extract(hdr.ipv4);
                packet.extract(hdr.tcp);
				transition select (hdr.ipv4.dscp){
					INT: qint;
					default: accept;
				}
		}
        
        state qint {
            packet.extract(hdr.qint_space);
            transition select (hdr.qint_space.space_hop){
                0 : qint_hop_1;           
                1 : qint_hop_2;
                2 : qint_hop_3;
                3 : qint_hop_4;
                default: accept;
            }
        }

        // state qint {
        //     packet.extract(hdr.qint_info_hop);
        //     transition select (hdr.qint_info_hop.hop_space){
        //         0 : qint_hop_1;           
        //         1 : qint_hop_2;
        //         2 : qint_hop_3;
        //         3 : qint_hop_4;
        //         default: accept;
        //     }
        // }

        state qint_hop_1 {
            packet.extract(hdr.qint_hop_1);
            transition accept;
        }

        state qint_hop_2 {
            packet.extract(hdr.qint_hop_1);
            packet.extract(hdr.qint_hop_2);
            transition accept;
        }

        state qint_hop_3 {
            packet.extract(hdr.qint_hop_1);
            packet.extract(hdr.qint_hop_2);
            packet.extract(hdr.qint_hop_3);
            transition accept;
        }

        state qint_hop_4 {
            packet.extract(hdr.qint_hop_1);
            packet.extract(hdr.qint_hop_2);
            packet.extract(hdr.qint_hop_3);
            packet.extract(hdr.qint_hop_4);
            transition accept;
        }

}


control SwitchIngressDeparser(packet_out packet, 
                             inout headers hdr,
                             in ingress_metadata_t ig_md,
                             in ingress_intrinsic_metadata_for_deparser_t ig_dprsr_md) {
		apply {
				packet.emit(hdr.local_report_header);
				packet.emit(hdr.ethernet);
                packet.emit(hdr.ipv4);
                packet.emit(hdr.tcp);
                // packet.emit(hdr.qint_info_hop);
                packet.emit(hdr.qint_num);
                packet.emit(hdr.qint_space);
                packet.emit(hdr.qint_hop_1);
                packet.emit(hdr.qint_hop_2);
                packet.emit(hdr.qint_hop_3);
                packet.emit(hdr.qint_hop_4);
		}
}

parser SwitchEgressParser(packet_in packet,
                          out headers hdr,
                          out egress_metadata_t eg_md, 
                          out egress_intrinsic_metadata_t eg_intr_md) {
		state start {
				packet.extract(hdr.ethernet);
				packet.extract(hdr.ipv4);
                packet.extract(hdr.tcp);
				transition select (hdr.ipv4.dscp){
					INT: qint;
					default: accept;
				}
		}
        
        state qint {
            packet.extract(hdr.qint_space);
            transition select (hdr.qint_space.space_hop){
                0 : qint_hop_1;           
                1 : qint_hop_2;
                2 : qint_hop_3;
                3 : qint_hop_4;
                default: accept;
            }
        }

        // state qint {
        //     packet.extract(hdr.qint_info_hop);
        //     transition select (hdr.qint_info_hop.hop_space){
        //         0 : qint_hop_1;           
        //         1 : qint_hop_2;
        //         2 : qint_hop_3;
        //         3 : qint_hop_4;
        //         default: accept;
        //     }
        // }

        state qint_hop_1 {
            packet.extract(hdr.qint_hop_1);
            transition accept;
        }

        state qint_hop_2 {
            packet.extract(hdr.qint_hop_1);
            packet.extract(hdr.qint_hop_2);
            transition accept;
        }

        state qint_hop_3 {
            packet.extract(hdr.qint_hop_1);
            packet.extract(hdr.qint_hop_2);
            packet.extract(hdr.qint_hop_3);
            transition accept;
        }

        state qint_hop_4 {
            packet.extract(hdr.qint_hop_1);
            packet.extract(hdr.qint_hop_2);
            packet.extract(hdr.qint_hop_3);
            packet.extract(hdr.qint_hop_4);
            transition accept;
        }
}

control SwitchEgressDeparser(packet_out packet, 
                             inout headers hdr,
                             in egress_metadata_t eg_md, 
                             in egress_intrinsic_metadata_for_deparser_t eg_dprsr_md) {
		apply {
				packet.emit(hdr);
		}
}