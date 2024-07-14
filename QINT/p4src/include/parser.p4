
parser MyParser(packet_in packet,
                out headers hdr,
                inout metadata meta,
                inout standard_metadata_t standard_metadata) {

		state start {
				packet.extract(hdr.ethernet);
				packet.extract(hdr.ipv4);
				transition select (hdr.ipv4.dscp){
					INT: qint;
					default: accept;
				}
		}
        
        state qint {
            packet.extract(hdr.qint_info);
            transition select (hdr.qint_info.hop_space){
                0 : qint_hop_1;           
                1 : qint_hop_2;
                2 : qint_hop_3;
                3 : qint_hop_4;
                default: accept;
            }
        }

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

control MyDeparser(packet_out packet, 
                   in headers hdr) {
		apply {
				packet.emit(hdr.ethernet);
				packet.emit(hdr.ipv4);
                packet.emit(hdr.qint_info);
                packet.emit(hdr.qint_hop_1);
                packet.emit(hdr.qint_hop_2);
                packet.emit(hdr.qint_hop_3);
                packet.emit(hdr.qint_hop_4);
		}
}
