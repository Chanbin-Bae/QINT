action encoding_hop(bit<32> index){
    encoding_info_hop.read(encoding_bit_hop, index);
    encoding_info_hop.read(encoding_level_hop, index+1);
    hdr.qint_info.num_hop = hdr.qint_info.num_hop + (bit<6>) encoding_level_hop;
    if (hdr.qint_info.num_hop > 32){
        hdr.qint_info.hop_space = hdr.qint_info.hop_space + 1;
        hdr.qint_info.num_hop = 0;
        meta.check_space_hop = true;
    }
}

#define SET_HOP(i)\
action set_hop##i##(){\
    hdr.qint_hop_##i##.qint_data = hdr.qint_hop_##i##.qint_data << ((bit<8>) encoding_level_hop);\
    hdr.qint_hop_##i##.qint_data = hdr.qint_hop_##i##.qint_data + encoding_bit_hop;\
}\

SET_HOP(1)
SET_HOP(2)
SET_HOP(3)
SET_HOP(4)
