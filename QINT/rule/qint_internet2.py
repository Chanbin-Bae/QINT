from p4utils.utils.sswitch_thrift_API import *
from time import sleep

global encoding_bit_hop,encoding_level_hop, hop_interval

encoding_bit_hop = []
encoding_level_hop = []
hop_interval = []


def load_lists_from_file(filename):
    tuple1 = []
    data = []
    with open(filename, 'r') as file:
        count = 1
        for line in file:
            if count == 3:
                tuple1 = []
                index1 = list(filter(lambda x: line[x] == "(", range(len(line))))
                index2 = list(filter(lambda x: line[x] == ")", range(len(line))))
                for i in range(len(index1)):
                    test1 = line[index1[i]:index2[i]+1]
                    tuple1.append(test1)
                count +=1
                data.append(tuple1)
            else:
                test = line.strip().split(',')
                data.append(test)
            count +=1
    return data

def assigned_encoding_info ():
    global encoding_bit_hop,encoding_level_hop, hop_interval
    file_path = "/home/mncgpu5/chanbin/QINT_final/rule/save_information8_internet2.txt"
    encoding_info = load_lists_from_file(file_path)
    hop_encoding_bit = encoding_info[0]
    for bit in hop_encoding_bit:
        bits = int(bit,2)
        encoding_bit_hop.append(bits)
    encoding_level_hop = encoding_info[1]
    interval_hop = encoding_info[2]

    for i in range(len(interval_hop)):
        h_interval = eval(interval_hop[i])
        hop_interval.append(h_interval)

class Controller(object):
 
    def __init__(self): 
        self.controller_sw1 = SimpleSwitchThriftAPI(9090)
        self.controller_sw2 = SimpleSwitchThriftAPI(9091)
        self.controller_sw3 = SimpleSwitchThriftAPI(9092)
        self.controller_sw4 = SimpleSwitchThriftAPI(9093)
        self.controller_sw5 = SimpleSwitchThriftAPI(9094)
        self.controller_sw6 = SimpleSwitchThriftAPI(9095)
        self.controller_sw7 = SimpleSwitchThriftAPI(9096)
        self.controller_sw8 = SimpleSwitchThriftAPI(9097)
        self.controller_sw9 = SimpleSwitchThriftAPI(9098)
        self.controller_sw10 = SimpleSwitchThriftAPI(9099)
        self.controller_sw11 = SimpleSwitchThriftAPI(9100)
        self.controller_sw12 = SimpleSwitchThriftAPI(9101)
        self.controller_sw13 = SimpleSwitchThriftAPI(9102)

    def set_source(self):
        self.controller_sw1.table_add("tb_set_source","int_set_source",['0x3'])
        self.controller_sw2.table_add("tb_set_source","int_set_source",['0x3'])
        self.controller_sw3.table_add("tb_set_source","int_set_source",['0x3'])
        self.controller_sw4.table_add("tb_set_source","int_set_source",['0x3'])
        self.controller_sw5.table_add("tb_set_source","int_set_source",['0x3'])
        self.controller_sw6.table_add("tb_set_source","int_set_source",['0x3'])
        self.controller_sw7.table_add("tb_set_source","int_set_source",['0x3'])
        self.controller_sw8.table_add("tb_set_source","int_set_source",['0x3'])
        self.controller_sw9.table_add("tb_set_source","int_set_source",['0x3'])
        self.controller_sw10.table_add("tb_set_source","int_set_source",['0x3'])
        self.controller_sw11.table_add("tb_set_source","int_set_source",['0x3'])
        self.controller_sw12.table_add("tb_set_source","int_set_source",['0x3'])
        self.controller_sw13.table_add("tb_set_source","int_set_source",['0x3'])

    def set_switchID(self):
        self.controller_sw1.table_add("tb_set_switch_id","set_switch_id",['4'],['1'])
        self.controller_sw2.table_add("tb_set_switch_id","set_switch_id",['4'],['2'])
        self.controller_sw3.table_add("tb_set_switch_id","set_switch_id",['4'],['3'])
        self.controller_sw4.table_add("tb_set_switch_id","set_switch_id",['4'],['4'])
        self.controller_sw5.table_add("tb_set_switch_id","set_switch_id",['4'],['5'])
        self.controller_sw6.table_add("tb_set_switch_id","set_switch_id",['4'],['6'])
        self.controller_sw7.table_add("tb_set_switch_id","set_switch_id",['4'],['7'])
        self.controller_sw8.table_add("tb_set_switch_id","set_switch_id",['4'],['8'])
        self.controller_sw9.table_add("tb_set_switch_id","set_switch_id",['4'],['9'])
        self.controller_sw10.table_add("tb_set_switch_id","set_switch_id",['4'],['10'])
        self.controller_sw11.table_add("tb_set_switch_id","set_switch_id",['4'],['11'])
        self.controller_sw12.table_add("tb_set_switch_id","set_switch_id",['4'],['12'])
        self.controller_sw13.table_add("tb_set_switch_id","set_switch_id",['4'],['13'])
    
    def routing_table(self):
        self.controller_sw1.table_add("tb_forward","set_egress_port",['10.0.13.5'],['3'])
        self.controller_sw1.table_add("tb_forward","set_egress_port",['10.0.13.6'],['4'])
        
        self.controller_sw2.table_add("tb_forward","set_egress_port",['10.0.13.5'],['2'])
        
        self.controller_sw3.table_add("tb_forward","set_egress_port",['10.0.13.6'],['2'])
        
        self.controller_sw4.table_add("tb_forward","set_egress_port",['10.0.13.5'],['2'])
        
        self.controller_sw5.table_add("tb_forward","set_egress_port",['10.0.13.6'],['2'])
        
        self.controller_sw6.table_add("tb_forward","set_egress_port",['10.0.13.5'],['2'])

        self.controller_sw7.table_add("tb_forward","set_egress_port",['10.0.13.6'],['3'])
        self.controller_sw7.table_add("tb_forward","set_egress_port",['10.0.13.7'],['3'])

        self.controller_sw8.table_add("tb_forward","set_egress_port",['10.0.13.5'],['2'])

        self.controller_sw9.table_add("tb_forward","set_egress_port",['10.0.13.6'],['2'])
        self.controller_sw9.table_add("tb_forward","set_egress_port",['10.0.13.7'],['2'])

        self.controller_sw10.table_add("tb_forward","set_egress_port",['10.0.13.5'],['3'])
        self.controller_sw10.table_add("tb_forward","set_egress_port",['10.0.13.6'],['3'])
        self.controller_sw10.table_add("tb_forward","set_egress_port",['10.0.13.7'],['3'])

        self.controller_sw11.table_add("tb_forward","set_egress_port",['10.0.13.5'],['3'])
        self.controller_sw11.table_add("tb_forward","set_egress_port",['10.0.13.6'],['3'])
        self.controller_sw11.table_add("tb_forward","set_egress_port",['10.0.13.7'],['3'])
        self.controller_sw11.table_add("tb_forward","set_egress_port",['10.0.13.8'],['3'])

        self.controller_sw12.table_add("tb_forward","set_egress_port",['10.0.13.5'],['2'])
        self.controller_sw12.table_add("tb_forward","set_egress_port",['10.0.13.6'],['2'])
        self.controller_sw12.table_add("tb_forward","set_egress_port",['10.0.13.7'],['2'])
        self.controller_sw12.table_add("tb_forward","set_egress_port",['10.0.13.8'],['2'])

        self.controller_sw13.table_add("tb_forward","set_egress_port",['10.0.13.5'],['1'])
        self.controller_sw13.table_add("tb_forward","set_egress_port",['10.0.13.6'],['2'])
        self.controller_sw13.table_add("tb_forward","set_egress_port",['10.0.13.7'],['3'])
        self.controller_sw13.table_add("tb_forward","set_egress_port",['10.0.13.8'],['4'])

    # self.controller_sw1.table_add("table_name", "action_name",[input], [action_param])
    def set_register(self):
        global encoding_bit_hop,encoding_level_hop,hop_interval
        for i in range(int(len(encoding_bit_hop)/2)):
            self.controller_sw1.register_write("encoding_info_hop",2*i, encoding_bit_hop[i])
            self.controller_sw1.register_write("encoding_info_hop",2*i+1, encoding_level_hop[i])
            self.controller_sw2.register_write("encoding_info_hop",2*i, encoding_bit_hop[i])
            self.controller_sw2.register_write("encoding_info_hop",2*i+1, encoding_level_hop[i])
            self.controller_sw3.register_write("encoding_info_hop",2*i, encoding_bit_hop[i])
            self.controller_sw3.register_write("encoding_info_hop",2*i+1, encoding_level_hop[i])
            self.controller_sw4.register_write("encoding_info_hop",2*i, encoding_bit_hop[i])
            self.controller_sw4.register_write("encoding_info_hop",2*i+1, encoding_level_hop[i])
            self.controller_sw5.register_write("encoding_info_hop",2*i, encoding_bit_hop[i])
            self.controller_sw5.register_write("encoding_info_hop",2*i+1, encoding_level_hop[i])
            self.controller_sw6.register_write("encoding_info_hop",2*i, encoding_bit_hop[i])
            self.controller_sw6.register_write("encoding_info_hop",2*i+1, encoding_level_hop[i])
            self.controller_sw7.register_write("encoding_info_hop",2*i, encoding_bit_hop[i])
            self.controller_sw7.register_write("encoding_info_hop",2*i+1, encoding_level_hop[i])
            self.controller_sw8.register_write("encoding_info_hop",2*i, encoding_bit_hop[i])
            self.controller_sw8.register_write("encoding_info_hop",2*i+1, encoding_level_hop[i])
            self.controller_sw9.register_write("encoding_info_hop",2*i, encoding_bit_hop[i])
            self.controller_sw9.register_write("encoding_info_hop",2*i+1, encoding_level_hop[i])
            self.controller_sw10.register_write("encoding_info_hop",2*i, encoding_bit_hop[i])
            self.controller_sw10.register_write("encoding_info_hop",2*i+1, encoding_level_hop[i])
            self.controller_sw11.register_write("encoding_info_hop",2*i, encoding_bit_hop[i])
            self.controller_sw11.register_write("encoding_info_hop",2*i+1, encoding_level_hop[i])
            self.controller_sw12.register_write("encoding_info_hop",2*i, encoding_bit_hop[i])
            self.controller_sw12.register_write("encoding_info_hop",2*i+1, encoding_level_hop[i])
            self.controller_sw13.register_write("encoding_info_hop",2*i, encoding_bit_hop[i])
            self.controller_sw13.register_write("encoding_info_hop",2*i+1, encoding_level_hop[i])
    
    def encoding_hop(self):
        global hop_interval
        for i in range(int(len(hop_interval)/2)):
            range_info = str(hop_interval[i][0])+"->"+str(hop_interval[i][1])
            self.controller_sw1.table_add("tb_encoding_hop","encoding_hop",[range_info],[str(2*i)])
            self.controller_sw2.table_add("tb_encoding_hop","encoding_hop",[range_info],[str(2*i)])
            self.controller_sw3.table_add("tb_encoding_hop","encoding_hop",[range_info],[str(2*i)])
            self.controller_sw4.table_add("tb_encoding_hop","encoding_hop",[range_info],[str(2*i)])
            self.controller_sw5.table_add("tb_encoding_hop","encoding_hop",[range_info],[str(2*i)])
            self.controller_sw6.table_add("tb_encoding_hop","encoding_hop",[range_info],[str(2*i)])
            self.controller_sw7.table_add("tb_encoding_hop","encoding_hop",[range_info],[str(2*i)])
            self.controller_sw8.table_add("tb_encoding_hop","encoding_hop",[range_info],[str(2*i)])
            self.controller_sw9.table_add("tb_encoding_hop","encoding_hop",[range_info],[str(2*i)])
            self.controller_sw10.table_add("tb_encoding_hop","encoding_hop",[range_info],[str(2*i)])
            self.controller_sw11.table_add("tb_encoding_hop","encoding_hop",[range_info],[str(2*i)])
            self.controller_sw12.table_add("tb_encoding_hop","encoding_hop",[range_info],[str(2*i)])
            self.controller_sw13.table_add("tb_encoding_hop","encoding_hop",[range_info],[str(2*i)])

if __name__ == "__main__":
    assigned_encoding_info()

    controller = Controller()
    
    controller.set_source()
    controller.set_switchID()
    controller.routing_table()
    controller.set_register()
    controller.encoding_hop()
