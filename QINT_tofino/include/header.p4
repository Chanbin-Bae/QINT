typedef bit<9>  egressSpec_t;
typedef bit<48> macAddr_t;
typedef bit<32> ip4Addr_t;

header ethernet_t {
		macAddr_t dstAddr;
		macAddr_t srcAddr;
		bit<16>   etherType;
}

header ipv4_t {
		bit<4>    version;
		bit<4>    ihl;
		bit<8>    dscp;
		bit<16>   totalLen;
		bit<16>   identification;
		bit<3>    flags;
		bit<13>   fragOffset;
		bit<8>    ttl;
		bit<8>    protocol;
		bit<16>   hdrChecksum;
		ip4Addr_t srcAddr;
		ip4Addr_t dstAddr;
}

header tcp_t {
    bit<16> srcPort;
    bit<16> dstPort;
    bit<32> seqNo;
    bit<32> ackNo;
    bit<4>  dataOffset;
    bit<3>  res;
    bit<3>  ecn;
    bit<6>  ctrl;
    bit<16> window;
    bit<16> checksum;
    bit<16> urgentPtr;
}

// header qint_info_hop_t{
//     bit<6> num_hop;
//     bit<2> hop_space;
//     bit<8> padding;
// }

header qint_num_t {
    bit<6> num_hop;
    bit<2> padding;
}

header qint_space_t {
    bit<2> space_hop;
    bit<6> padding;
}

header qint_t{
    bit<32> qint_data;
}

header local_report_header_t {
    bit<16> ingress_port_id;
    bit<8>  queue_id;
    bit<64> ingress_global_tstamp;
}

struct headers {
    local_report_header_t       local_report_header; // check!
	ethernet_t   ethernet;
	ipv4_t       ipv4;
    tcp_t        tcp;
    // qint_info_hop_t qint_info_hop;
    qint_num_t qint_num;
    qint_space_t qint_space;

    qint_t qint_hop_1;
    qint_t qint_hop_2;
    qint_t qint_hop_3;
    qint_t qint_hop_4;
}

struct metadata_t {
    bit<32> switch_id;
    bit<32> index_hop;
    bit<19> hop_latency;    
    bit<6> encoding_level_hop;
    
    bool source;

    bool check_hop;
    bool check_space_hop;
}

struct ingress_metadata_t {
    metadata_t meta;
}

struct egress_metadata_t {
    metadata_t meta;
}