
PCAP_DIR 	= 	pcap
LOG_DIR 	= 	log
P4SRC_DIR	=	p4src	 

ifndef P4SRC_FILE

P4SRC_FILE = /home/mncgpu5/chanbin/QINT_final/p4src/qint.p4
endif

all: run

qint_ft:
	sudo python3 network.py --p4 ${P4SRC_FILE} --topo fat-tree
qint_it:
	sudo python3 network.py --p4 ${P4SRC_FILE} --topo internet2

stop:
	sudo mn -c

clean: stop
	sudo rm -f *.pcap
	# rm -rf $(PCAP_DIR) $(LOG_DIR) $(RULE_DIR)/rule*
	sudo rm -rf $(PCAP_DIR) $(LOG_DIR)
