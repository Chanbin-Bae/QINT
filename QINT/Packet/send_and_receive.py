from scapy.all import *
from scapy.all import PcapReader, sendp, Ether, IP, TCP, sendpfast
from time import sleep
import time
import threading
import argparse
import csv

global time_interval, packets, packet_total
packets = []
packet_total = []
time_interval = []

parser = argparse.ArgumentParser(description='receiver parser')
parser.add_argument('--host', help='Host ID.', type=str, required=True)
parser.add_argument('--topo', help='Network Topology.', type=str, required=True)
args = parser.parse_args()

#################################################################################################
##########                        QINT packet header definition                        ##########
#################################################################################################

class qint_info(Packet):
    """qint_info"""
    
    name = "qint_info"
    
    fields_desc = [
        BitField('hop_number',0,6),
        BitField('hop_space',0,2)
    ]
    
class qint_hop_1(Packet):
    """qint_hop_1"""
    
    name = "qint_hop_header_1"
    
    fields_desc = [
        BitField('qint_hop',0,32)
    ]

class qint_hop_2(Packet):
    """qint_hop_2"""
    
    name = "qint_hop_header_2"
    
    fields_desc = [
        BitField('qint_hop',0,32)
    ]

class qint_hop_3(Packet):
    """qint_hop_3"""
    
    name = "qint_hop_header_3"
    
    fields_desc = [
        BitField('qint_hop',0,32)
    ]

class qint_hop_4(Packet):
    """qint_hop_4"""
    
    name = "qint_hop_header_4"
    
    fields_desc = [
        BitField('qint_hop',0,32)
    ]

#################################################################################################
##########                               Packet Creation                               ##########
#################################################################################################
def create_packet(source_ip, destination_ip, flow_size):
    global src_port, dst_port
    packet = Ether(src=get_if_hwaddr(iface), dst='ff:ff:ff:ff:ff:ff') / IP(src=source_ip, dst=destination_ip, tos=3) 
    packet = packet / (b'\x00' * flow_size)    
    return packet

def generate_packet_distribution():
    global file_path, src_ip, packet_total, packets, time_interval
    if args.topo == "fat-tree":
        if args.host == "h1":
            src_ip = "10.0.1.1"
        if args.host == "h2":
            src_ip = "10.0.1.2"
        if args.host == "h3":
            src_ip = "10.0.2.3"
        if args.host == "h4":
            src_ip = "10.0.2.4"
        if args.host == "h5":
            src_ip = "10.0.3.5"
        if args.host == "h6":
            src_ip = "10.0.3.6"
        if args.host == "h7":
            src_ip = "10.0.4.7"
        if args.host == "h8":
            src_ip = "10.0.4.8"
        file_path = "~/QINT/Packet/Traffic/fb10_b1_h8.csv"
    else:
        if args.host == "h1":
            src_ip = "10.0.1.1"
        if args.host == "h2":
            src_ip = "10.0.1.2"
        if args.host == "h3":
            src_ip = "10.0.7.3"
        if args.host == "h4":
            src_ip = "10.0.11.4"
        file_path = "~/QINT/Packet/Traffic/wb20_b1_h4.csv"

    prev_packet_generation =[]
    with open(file_path, 'r') as csvfile:
        csv_reader = csv.reader(csvfile)
        for row in csv_reader:
            source_ip = row[0]
            packet_generation_time = float(row[3])
            prev_packet_generation.append(packet_generation_time) 
            if source_ip == src_ip:
                if not time_interval:
                    time_interval.append(packet_generation_time)
                else:
                    packet_interval = packet_generation_time - prev_packet_generation[-2] if len(prev_packet_generation) > 1 else packet_generation_time - prev_packet_generation[-1]
                    time_interval.append(packet_interval)
                    
    with open(file_path, 'r') as csvfile:
        csv_reader = csv.reader(csvfile)
        for row in csv_reader:
            source_ip = row[0]
            destination_ip = row[1]
            flow_size = int(row[2])
            
            # 패킷 생성 및 리스트에 추가
            if source_ip == src_ip:
                if flow_size > 1000:
                    while flow_size > 1000:
                        flow_size -= 1000
                        packet = create_packet(source_ip, destination_ip, 1000)
                        packets.append(packet)
                    packet = create_packet(source_ip, destination_ip, flow_size)
                    packets.append(packet)
                    packet_total.append(packets)
                else:
                    packet = create_packet(source_ip, destination_ip, flow_size)
                    packets.append(packet)
                    packet_total.append(packets)

def sending_packets():
    global time_interval, packet_total, packets, iface
    count = 0
    for flow in packet_total:
        sendpfast(flow, iface=iface, pps = 200)
        sleep(time_interval[count])
        count += 1

#################################################################################################
##########                             QINT receive logic                              ##########
#################################################################################################

def handle_pkt_Q1(pkt):
    if pkt[IP].tos != 0x3:
        if qint_info in pkt:
            qint_info_pkt = pkt[qint_info]
            if qint_info_pkt.hop_space == 0:
                if qint_hop_1 in pkt:
                    print("QintData_1 :",pkt[qint_hop_1].qint_hop)
            elif qint_info_pkt.hop_space == 1:
                if qint_hop_1 in pkt:
                    print("QintData_1 :",pkt[qint_hop_1].qint_hop)
                if qint_hop_2 in pkt:
                    print("QintData_2 :",pkt[qint_hop_2].qint_hop)
            elif qint_info_pkt.hop_space == 2:
                if qint_hop_1 in pkt:
                    print("QintData_1 :",pkt[qint_hop_1].qint_hop)
                if qint_hop_2 in pkt:
                    print("QintData_2 :",pkt[qint_hop_2].qint_hop)
                if qint_hop_3 in pkt:
                    print("QintData_3 :",pkt[qint_hop_3].qint_hop)
            elif qint_info_pkt.hop_space == 3:
                if qint_hop_1 in pkt:
                    print("QintData_1 :",pkt[qint_hop_1].qint_hop)
                if qint_hop_2 in pkt:
                    print("QintData_2 :",pkt[qint_hop_2].qint_hop)
                if qint_hop_3 in pkt:
                    print("QintData_3 :",pkt[qint_hop_3].qint_hop)
                if qint_hop_4 in pkt:
                    print("QintData_4 :",pkt[qint_hop_4].qint_hop)

def receive_packet_Q1():
    global iface
    while True:
        bind_layers(IP, qint_info)
        bind_layers(qint_info,qint_hop_1, hop_space=0)
        try:
            sniff(iface=iface, prn = lambda x: handle_pkt_Q1(x))
        except:
            continue

def receive_packet_Q2():
    global iface
    while True:
        bind_layers(IP, qint_info)
        bind_layers(qint_info, qint_hop_1, hop_space=1)
        bind_layers(qint_hop_1, qint_hop_2)
        try:
            sniff(iface=iface, prn=lambda x: handle_pkt_Q1(x))
        except Exception as e:
            continue

def receive_packet_Q3():
    global iface
    while True:
        bind_layers(IP, qint_info)  # Check this condition
        bind_layers(qint_info,qint_hop_1, hop_space=2)
        bind_layers(qint_hop_1,qint_hop_2)
        bind_layers(qint_hop_2,qint_hop_3)
        try:
            sniff(iface=iface, prn = lambda x: handle_pkt_Q1(x))
        except Exception as e:
            continue

def receive_packet_Q4():
    global iface
    while True:
        bind_layers(IP, qint_info)  # Check this condition
        bind_layers(qint_info,qint_hop_1, hop_space=3)
        bind_layers(qint_hop_1,qint_hop_2)
        bind_layers(qint_hop_2,qint_hop_3)
        bind_layers(qint_hop_3,qint_hop_4)
        try:
            sniff(iface=iface, prn = lambda x: handle_pkt_Q1(x))
        except Exception as e:
            continue

################################################################################################
##########                                    Main                                    ##########
################################################################################################

def main():
    global iface
    init_time = time.time()
    
    ifaces = [i for i in os.listdir('/sys/class/net/') if 'eth' in i]
    iface = ifaces[0]
    
    file_name = "/home/mncgpu5/chanbin/QINT_final/result/test_"+iface+"_"+str(args.topo)+".txt"
    sys.stdout = open(file_name,'w')

    receive_thread1 = threading.Thread(target=receive_packet_Q1, args=())
    receive_thread1.daomon = True
    receive_thread1.start()

    receive_thread2 = threading.Thread(target=receive_packet_Q2, args=())
    receive_thread2.daomon = True
    receive_thread2.start()

    receive_thread3 = threading.Thread(target=receive_packet_Q3, args=())
    receive_thread3.daomon = True
    receive_thread3.start()

    receive_thread4 = threading.Thread(target=receive_packet_Q4, args=())
    receive_thread4.daomon = True
    receive_thread4.start()
    
    if args.topo == "internet2":
        sending_host = ["h1","h2","h3","h4"]
    else:
        sending_host = ["h1","h2","h3","h4","h5","h6","h7","h8"]

    if args.host in sending_host:
        sleep(30)
        generate_packet_distribution()
        
        current_time = 0
        while current_time < 150:
            current_time = time.time()-init_time
        sending_packets()
        count = 0
        while True:
            count += 1
    else:
        while True:
            count += 1

    
if __name__ == '__main__':
    main()
    
