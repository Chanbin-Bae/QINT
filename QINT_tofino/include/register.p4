Register<bit<8>, _>(1024) rg_encoding_level_hop; // 0: section start, 1: section final, 2: encoding bit, 3: quantization level
Register<bit<32>, _>(1024) rg_encoding_bit_hop;
Register<bit<8>, _>(4) rg_space;

RegisterAction<bit<32>, _, bit<32>>(rg_encoding_bit_hop) do_check_encoding_bit_hop  = {
    void apply(inout bit<32> value, out bit<32> read_value){
        read_value = value;
    }
};

RegisterAction<bit<8>, _, bit<8>>(rg_encoding_level_hop) do_check_encoding_level_hop  = {
    void apply(inout bit<8> value, out bit<8> read_value){
        read_value = value;
    }
};

RegisterAction<bit<8>, _, bit<8>>(rg_space) update_space  = {
    void apply(inout bit<8> value, out bit<8> read_value){
        read_value = value;
        
    }
};