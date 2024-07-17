action nop()
{
}


action reset_num_hop(){
    // hdr.qint_info_hop.num_hop = eg_md.meta.encoding_level_hop;
	hdr.qint_num.num_hop = eg_md.meta.encoding_level_hop;
}

action update_space_hop() {
	hdr.qint_space.space_hop = (bit<2>) update_space.execute((bit<8>) hdr.qint_space.space_hop);
	eg_md.meta.check_space_hop = true;
}

action check_encoding_bit_hop(){
    encoding_bit_hop = do_check_encoding_bit_hop.execute(eg_md.meta.index_hop);
}
action encoding_hop(bit<32> index){
	eg_md.meta.encoding_level_hop = (bit<6>) do_check_encoding_level_hop.execute(index);
    eg_md.meta.index_hop = index;
}

#define SET_HOP(i)\
action set_hop_##i##(){\
    hdr.qint_hop_##i##.qint_data = hdr.qint_hop_##i##.qint_data + encoding_bit_hop;\
}\

#define SHIFT_HOP(i, j)\
action shift_hop_##i##_##j##(){\
    hdr.qint_hop_##i##.qint_data = hdr.qint_hop_##i##.qint_data << (##j##);\
}\


SET_HOP(1)
SET_HOP(2)
SET_HOP(3)
SET_HOP(4)

SHIFT_HOP(1,1)
SHIFT_HOP(1,2)
SHIFT_HOP(1,3)
SHIFT_HOP(1,4)
SHIFT_HOP(1,5)
SHIFT_HOP(1,6)
SHIFT_HOP(1,7)
SHIFT_HOP(1,8)
SHIFT_HOP(1,9)
SHIFT_HOP(1,10)
SHIFT_HOP(1,11)
SHIFT_HOP(1,12)
SHIFT_HOP(1,13)
SHIFT_HOP(1,14)
SHIFT_HOP(1,15)
SHIFT_HOP(1,16)
SHIFT_HOP(2,1)
SHIFT_HOP(2,2)
SHIFT_HOP(2,3)
SHIFT_HOP(2,4)
SHIFT_HOP(2,5)
SHIFT_HOP(2,6)
SHIFT_HOP(2,7)
SHIFT_HOP(2,8)
SHIFT_HOP(2,9)
SHIFT_HOP(2,10)
SHIFT_HOP(2,11)
SHIFT_HOP(2,12)
SHIFT_HOP(2,13)
SHIFT_HOP(2,14)
SHIFT_HOP(2,15)
SHIFT_HOP(2,16)
SHIFT_HOP(3,1)
SHIFT_HOP(3,2)
SHIFT_HOP(3,3)
SHIFT_HOP(3,4)
SHIFT_HOP(3,5)
SHIFT_HOP(3,6)
SHIFT_HOP(3,7)
SHIFT_HOP(3,8)
SHIFT_HOP(3,9)
SHIFT_HOP(3,10)
SHIFT_HOP(3,11)
SHIFT_HOP(3,12)
SHIFT_HOP(3,13)
SHIFT_HOP(3,14)
SHIFT_HOP(3,15)
SHIFT_HOP(3,16)
SHIFT_HOP(4,1)
SHIFT_HOP(4,2)
SHIFT_HOP(4,3)
SHIFT_HOP(4,4)
SHIFT_HOP(4,5)
SHIFT_HOP(4,6)
SHIFT_HOP(4,7)
SHIFT_HOP(4,8)
SHIFT_HOP(4,9)
SHIFT_HOP(4,10)
SHIFT_HOP(4,11)
SHIFT_HOP(4,12)
SHIFT_HOP(4,13)
SHIFT_HOP(4,14)
SHIFT_HOP(4,15)
SHIFT_HOP(4,16)

