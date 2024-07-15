import argparse
from p4utils.mininetlib.network_API import NetworkAPI
from mininet.net import Mininet
from mininet.node import Controller, RemoteController
from mininet.link import TCLink
from multiprocessing import Process
from time import sleep
import subprocess

# # Run command on Mininet node
def run_command_on_host(host_node, command):
    result = host_node.cmd(command)

# Configure Network
def config_network(p4, topo):
    net = NetworkAPI()

    # If want to use Mininet CLI, modify to True
    net.cli_enabled = False
    
    # Link option
    linkops = dict(bw=1000, loss=0, use_htb=True)

    # Network general options
    net.setLogLevel('info')
    if topo == "internet2":
        net.addP4Switch('s1')
        net.addP4Switch('s2')
        net.addP4Switch('s3')
        net.addP4Switch('s4')
        net.addP4Switch('s5')
        net.addP4Switch('s6')
        net.addP4Switch('s7')
        net.addP4Switch('s8')
        net.addP4Switch('s9')
        net.addP4Switch('s10')
        net.addP4Switch('s11')
        net.addP4Switch('s12')
        net.addP4Switch('s13')

        # Execute P4 program on switch
        net.setP4SourceAll(p4)

        # Generate hosts
        hosts = []
        for i in range (0,8):
            hosts.append(net.addHost('h%d' % (i+1)))    

        # Construct Network Topology : Internet2
        net.addLink('h1', 's1',**linkops)
        net.addLink('h2', 's1',**linkops)
        net.addLink('h3', 's7',**linkops)
        net.addLink('h4', 's11',**linkops)
        net.addLink('h5', 's13',**linkops)
        net.addLink('h6', 's13',**linkops)
        net.addLink('h7', 's13',**linkops)
        net.addLink('h8', 's13',**linkops)

        net.addLink('s1', 's2',**linkops)
        net.addLink('s2', 's4',**linkops)
        net.addLink('s4', 's6',**linkops)
        net.addLink('s6', 's8',**linkops)
        net.addLink('s8', 's10',**linkops)

        net.addLink('s1', 's3',**linkops)
        net.addLink('s3', 's5',**linkops)
        net.addLink('s5', 's7',**linkops)
        net.addLink('s7', 's9',**linkops)
        net.addLink('s9', 's10',**linkops)

        net.addLink('s10', 's11',**linkops)
        net.addLink('s11', 's12',**linkops)
        net.addLink('s12', 's13',**linkops)
        
    if topo == "fat-tree":
        # Network definition
        net.addP4Switch('s1')
        net.addP4Switch('s2')
        net.addP4Switch('s3')
        net.addP4Switch('s4')
        net.addP4Switch('s5')
        net.addP4Switch('s6')
        net.addP4Switch('s7')
        net.addP4Switch('s8')
        net.addP4Switch('s9')
        net.addP4Switch('s10')

        net.setP4SourceAll(p4)

        net.addHost('h1')
        net.addHost('h2')
        net.addHost('h3')
        net.addHost('h4')
        net.addHost('h5')
        net.addHost('h6')
        net.addHost('h7')
        net.addHost('h8')


        net.addLink('h1', 's1',**linkops)
        net.addLink('h2', 's1',**linkops)
        net.addLink('h3', 's2',**linkops)
        net.addLink('h4', 's2',**linkops)
        net.addLink('h5', 's3',**linkops)
        net.addLink('h6', 's3',**linkops)
        net.addLink('h7', 's4',**linkops)
        net.addLink('h8', 's4',**linkops)
        
        net.addLink('s1', 's5',**linkops)
        net.addLink('s1', 's6',**linkops)
        
        net.addLink('s2', 's5',**linkops)
        net.addLink('s2', 's6',**linkops)

        net.addLink('s3', 's7',**linkops)
        net.addLink('s3', 's8',**linkops)

        net.addLink('s4', 's7',**linkops)
        net.addLink('s4', 's8',**linkops)
        
        net.addLink('s5', 's9',**linkops)
        net.addLink('s5', 's10',**linkops)
        
        net.addLink('s6', 's9',**linkops)
        net.addLink('s6', 's10',**linkops)

        net.addLink('s7', 's9',**linkops)
        net.addLink('s7', 's10',**linkops)

        net.addLink('s8', 's9',**linkops)
        net.addLink('s8', 's10',**linkops)

    # Assignment strategy
    net.mixed()

    return net

# Parser
def get_args():
    parser = argparse.ArgumentParser()
    parser.add_argument('--p4', help='p4 src file.', type=str, required=False, default='p4src/int_mri.p4')
    parser.add_argument('--topo', help='evaluation topology', type=str, required=True)
    return parser.parse_args()


def main():
    args = get_args()
    net = config_network(args.p4, args.topo)
    net.startNetwork()

    sleep(30)

    # # Execute command on Mininet nodes simultaneously
    commands = []
    processes = []
    if args.topo == "internet2":    
        for i in range(0,8):
            command1 = 'python3 ~/QINT/Packet/send_and_receive.py --topo internet2 --host "h{0}"'.format((i+1))
            commands.append(command1)
        process1 = Process(target=run_command_on_host, args=(net.net.get('h1'), commands[0]))
        process1.start()
        processes.append(process1)

        process2 = Process(target=run_command_on_host, args=(net.net.get('h2'), commands[1]))
        process2.start()    
        processes.append(process2)

        process3 = Process(target=run_command_on_host, args=(net.net.get('h3'), commands[2]))
        process3.start()
        processes.append(process3)

        process4 = Process(target=run_command_on_host, args=(net.net.get('h4'), commands[3]))
        process4.start()
        processes.append(process4)

        process5 = Process(target=run_command_on_host, args=(net.net.get('h5'), commands[4]))
        process5.start()
        processes.append(process5)

        process6 = Process(target=run_command_on_host, args=(net.net.get('h6'), commands[5]))
        process6.start()    
        processes.append(process6)

        process7 = Process(target=run_command_on_host, args=(net.net.get('h7'), commands[6]))
        process7.start()
        processes.append(process7)

        process8 = Process(target=run_command_on_host, args=(net.net.get('h8'), commands[7]))
        process8.start()
        processes.append(process8)

    if args.topo == "fat-tree":    
        for i in range(0,8):
            command = 'python3 ~/QINT/Packet/send_and_receive.py --topo fat-tree --host "h{0}"'.format((i+1))
            commands.append(command)
        process1 = Process(target=run_command_on_host, args=(net.net.get('h1'), commands[0]))
        process1.start()
        processes.append(process1)

        process2 = Process(target=run_command_on_host, args=(net.net.get('h2'), commands[1]))
        process2.start()    
        processes.append(process2)

        process3 = Process(target=run_command_on_host, args=(net.net.get('h3'), commands[2]))
        process3.start()
        processes.append(process3)

        process4 = Process(target=run_command_on_host, args=(net.net.get('h4'), commands[3]))
        process4.start()
        processes.append(process4)

        process5 = Process(target=run_command_on_host, args=(net.net.get('h5'), commands[4]))
        process5.start()
        processes.append(process5)

        process6 = Process(target=run_command_on_host, args=(net.net.get('h6'), commands[5]))
        process6.start()    
        processes.append(process6)

        process7 = Process(target=run_command_on_host, args=(net.net.get('h7'), commands[6]))
        process7.start()
        processes.append(process7)

        process8 = Process(target=run_command_on_host, args=(net.net.get('h8'), commands[7]))
        process8.start()
        processes.append(process8)

    print(commands)
    
    for process in processes :
        process.join()
    
    # # Turn off the Mininet
    net.stopNetwork()


if __name__ == '__main__':
    main()
