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
		bit<4>    ctrl;
	        bit<4>    dscp;
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

header qint_info_t{
    bit<6> num_hop;
    bit<2> hop_space;
}

header qint_t{
    bit<32> qint_data;
}

struct headers {
    ethernet_t   ethernet;
    ipv4_t       ipv4;
    qint_info_t qint_info;
    qint_t qint_hop_1;
    qint_t qint_hop_2;
    qint_t qint_hop_3;
    qint_t qint_hop_4;
}

struct metadata {
    bit<32> switch_id;
    bool source;

    bit<32> encoding_bit_hop;
    bit<32> encoding_level_hop;
    bool check_hop;
    bool check_space_hop;
    bit<2> space_hop;
    bit<12> number_hop;
    bit<32> hop_latency;
}

