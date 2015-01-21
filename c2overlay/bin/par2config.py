import os
import sys
import pydot
from pygraph.classes.graph import graph
from pygraph.classes.digraph import digraph
from pygraph.readwrite.dot import write
from pygraph.readwrite import dot
from collections import deque

nets = {}


class Net:
        def __init__(self):
                self.source = []
                self.sinks = []
                self.trace = []
                self.name = ''

        def add_sink(self, x,y,pin_num):
                #self.sinks.append([x,y,pin_num])
                self.trace.append (Trace( 'SINK', (x,y),pin_num))

        def add_source(self, x,y,pin_num):
                #self.sinks.append([x,y,pin_num])       
                self.trace.append(Trace( 'SOURCE', (x,y),pin_num))

        def add_section(self, dir, x1,y1,x2,y2, channel):
                self.trace.append(Trace(dir, (x1,y1,x2,y2), channel))

class Trace:
        def __init__(self, type = '', location = (), index = -1, iatime = -1, nodename = 0):
                self.type = type
                self.loc = location
                self.index = index
		self.iatime = iatime
		self.nodename = nodename


def splitnums(string):
        string = string.replace('(','')
        string = string.replace(')','')
        return string.split(',')

def getchan(line):

        about = line.split()
        return int(about[-1])
        if line.find("inode") > -1:
                about = line.split()
                return int(about[5])

        else:
                about = line.split()
                return int(about[5])


def read_routing(filename ):
	fh = open(filename,"r")
	igot = fh.readlines()
	
	#size of the array
	x = int(igot[0].split(' ')[2])+1
	y = int(igot[0].split(' ')[4])+1
	width = x
	channels = 0
	opins = 0
	ipins = 0
	
	#find channel width
	'''for i,line in enumerate(igot):

		if line.find("CHAN") > -1:
			about = line.split()
			c1 = getchan(line)
			if c1 + 1 > channels:
				channels = c1 + 1
	'''
	channels = 4	

	in_net = False
	chanx = [[[[] for i in range(channels)] for col in range(width)] for row in range(width)]
	chany = [[[[] for i in range(channels)] for col in range(width)] for row in range(width)]
	opin = [[[[] for i in range(opins)] for col in range(width)] for row in range(width)]
	ipin = [[[[] for i in range(ipins)] for col in range(width)] for row in range(width)]
	
	


	lastchan = [-1, -1,-1,-1]
	thischan = [-1, -1,-1,-1]
	intrace = False
	signal = ''
	
	#we will build a net for each traced signal
	global nets
	routing_net = 0
	for i,line in enumerate(igot):
		if line.find("Net") > -1:
			signal = line.split('(')[1].split(')')[0]
			#print signal
			routing_net = Net()
			nets[signal] = routing_net
			routing_net.name = signal
		if line.find("OPIN") > -1:
		
			about = line.split()
			nums = splitnums(about[1])
			x1 = int(nums[0])
			y1 = int(nums[1])
	

			nums = splitnums(about[3])
			pin = int(nums[0])
			if len(routing_net.source) is 0:
				routing_net.source = [x1,y1,pin] 	
				routing_net.add_source(x1,y1,pin)
			else:
				routing_net.add_source(x1,y1,pin)
		if line.find("IPIN") > -1:
		
			about = line.split()
			nums = splitnums(about[1])
			x1 = int(nums[0])
			y1 = int(nums[1])
	

			nums = splitnums(about[3])
			pin = int(nums[0])
			
			routing_net.add_sink(x1,y1,pin)
			
				
			
		if line.find("CHANX") > -1:
			about = line.split()
			nums = splitnums(about[1])
			x1 = int(nums[0])
			y1 = int(nums[1])
			x2 = -1
			y2 = -1
			if len(about) >= 6:
				nums = splitnums(about[3])
				x2 = int(nums[0])
				y2 = int(nums[1])		
			
				
			c1 = getchan(line)	
			routing_net.add_section('X', x1,y1,x2,y2, c1)
			
			
		if line.find("CHANY") > -1:
			about = line.split()
			
			nums = splitnums(about[1])
			x1 = int(nums[0])
			y1 = int(nums[1])
			
			x2 = -1
			y2 = -1
			if len(about) >= 6:
				nums = splitnums(about[3])
				x2 = int(nums[0])
				y2 = int(nums[1])
			
			c1 = getchan(line)
		
			routing_net.add_section('Y', x1,y1,x2,y2, c1)

		#print routing_net.name
		#print routing_net.source
		
	#we now should have all routed signals in nets
	'''for mynode in nets:
		print nets[mynode].name
		print nets[mynode].source
		print nets[mynode].sinks
		#print len(nets[mynode].trace)
		for traces in range(0,len(nets[mynode].trace)):
			print 'Trace of %s:' %(mynode), nets[mynode].trace[traces].loc, nets[mynode].trace[traces].index, nets[mynode].trace[traces].type
	
	inputgraph = open('test.dot','r')
	graphdata = inputgraph.read()
	inputgraph.close() 
	graph = dot.read(graphdata)
	'''
	rrgraph = digraph()
	for mynode in nets:
		for traces in range(0,len(nets[mynode].trace)):
			trace_type = nets[mynode].trace[traces].type;
			trace_loc = r'%s,%s' % (nets[mynode].trace[traces].loc[0], nets[mynode].trace[traces].loc[1]);
			trace_index = nets[mynode].trace[traces].index;
			#print 'Trace of %s:' %(mynode), trace_loc, trace_index, trace_type
			if( (trace_type == 'X') | (trace_type == 'Y')):
				nodename = r'%s,%s,%s' % (trace_loc,trace_index,trace_type)
				nodeattr = ('nodetype', 'route')
			else:
				nodename = trace_loc
				nodeattr = ('nodetype', 'logic')		
			nets[mynode].trace[traces].nodename = nodename
			if(rrgraph.has_node(nodename)):
				#print "node exists!!"
				pass
			else:
				rrgraph.add_node(nodename)
				rrgraph.add_node_attribute(nodename, nodeattr)

		for traces in range(0,len(nets[mynode].trace)-1):
                        trace_type = nets[mynode].trace[traces].type;
			nodename = nets[mynode].trace[traces].nodename;
			next_nodename = nets[mynode].trace[traces+1].nodename 	
			if(trace_type!='SINK'):
				if(rrgraph.has_edge((nodename, next_nodename))):
					#print "edge exists!!"
					pass
				else:
					rrgraph.add_edge((nodename, next_nodename))
			


	'''for eachnode in graph:
		if(graph.incidents(eachnode)==[]):
			print eachnode
			mynode = eachnode
			for traces in range(0,len(nets[mynode].trace)):
				trace_type = nets[mynode].trace[traces].type;
				trace_loc = r'%s,%s' % (nets[mynode].trace[traces].loc[0], nets[mynode].trace[traces].loc[1]);
				trace_index = nets[mynode].trace[traces].index;
				print 'Trace of %s:' %(mynode), trace_loc, trace_index, trace_type
				if( (trace_type == 'X') | (trace_type == 'Y')):
					nodename = r'%s,%s,%s' % (trace_loc,trace_index,trace_type)
				else:
					nodename = trace_loc
				nets[mynode].trace[traces].nodename = nodename
				if(rrgraph.has_node(nodename)):
					print "node exists!!"
				else:
					rrgraph.add_node(nodename)

			for traces in range(0,len(nets[mynode].trace)-1):
                                trace_type = nets[mynode].trace[traces].type;
				nodename = nets[mynode].trace[traces].nodename;
				next_nodename = nets[mynode].trace[traces+1].nodename 	
				if(trace_type!='SINK'):
					if(rrgraph.has_edge((nodename, next_nodename))):
						print "edge exists!!"
					else:
						rrgraph.add_edge((nodename, next_nodename))
		else:
			print eachnode
                	mynode = eachnode
                	for traces in range(0,len(nets[mynode].trace)):
                    		trace_type = nets[mynode].trace[traces].type;
                                trace_loc = r'%s,%s' % (nets[mynode].trace[traces].loc[0], nets[mynode].trace[traces].loc[1]);
                                trace_index = nets[mynode].trace[traces].index;
                                print 'Trace of %s:' %(mynode), trace_loc, trace_index, trace_type
                                if( (trace_type == 'X') | (trace_type == 'Y')):
                                        nodename = r'%s,%s,%s' % (trace_loc,trace_index,trace_type)
                                else:
                                        nodename = trace_loc
                                nets[mynode].trace[traces].nodename = nodename
                                if(rrgraph.has_node(nodename)):
                                        print "node exists!!"
                                else:
                                        rrgraph.add_node(nodename)

                        for traces in range(0,len(nets[mynode].trace)-1):
                                trace_type = nets[mynode].trace[traces].type;
                                nodename = nets[mynode].trace[traces].nodename;
                                next_nodename = nets[mynode].trace[traces+1].nodename
                                if(trace_type!='SINK'):
                                        if(rrgraph.has_edge((nodename, next_nodename))):
                                                print "edge exists!!"
                                        else:
                                                rrgraph.add_edge((nodename, next_nodename))


        '''     
	for eachnode in rrgraph:
                if(rrgraph.incidents(eachnode)==[]):
                        for next_eachnode in rrgraph.neighbors(eachnode):
                                rrgraph.set_edge_label((eachnode, next_eachnode), 1)
		else:
			if(rrgraph.neighbors(eachnode)!=[]):
				for next_eachnode in rrgraph.neighbors(eachnode):
        	                        rrgraph.set_edge_label((eachnode, next_eachnode), -1)

	#nodelist = [[]]
	nodelist = {};
	for eachnode in rrgraph:
		if(rrgraph.incidents(eachnode)==[]):
			#if(rrgraph.neighbors(eachnode)!=[]):
			for next_eachnode in rrgraph.neighbors(eachnode):
				label = rrgraph.edge_label((eachnode, next_eachnode))
				if(label != -1):
					while(rrgraph.neighbors(next_eachnode)!=[]):
						for nextnext_eachnode in rrgraph.neighbors(next_eachnode):
							#print next_eachnode, nextnext_eachnode, label+1;
							labellist=[];
							for prevnode in rrgraph.incidents(next_eachnode):
								labellist.append(rrgraph.edge_label((prevnode, next_eachnode)));
							#print "labellist:", labellist
							label = max(labellist)
							del labellist;
							if(rrgraph.node_attributes(next_eachnode)[0][1] == 'logic'):
                                                       		label_level = label+8;
                                                        else:
                                                                label_level = label+1;
                                                                
							rrgraph.set_edge_label((next_eachnode, nextnext_eachnode), label_level);
							#print nodelist
							#nodelist.append((nextnext_eachnode, label+1))
							'''if(nextnext_eachnode in nodelist):
								if(nodelist[nextnext_eachnode]>label+1):
									nodelist[nextnext_eachnode] = nodelist[nextnext_eachnode];
								else: 
									nodelist[nextnext_eachnode] = label+1;
							else:'''
							nodelist[nextnext_eachnode] = label_level;
							
							#print nodelist
						next_eachnode = nextnext_eachnode
						#nodelist.remove((nextnext_eachnode, label+1))
						label = nodelist[nextnext_eachnode];
						del nodelist[nextnext_eachnode];
						#label = label+1
					
					#next_eachnode = nodelist[0][0];
					#label = nodelist[0][1]
					#print "start emptying nodelist"	
					while(nodelist!={}):
						#print nodelist
						#(next_eachnode, label) = nodelist.pop();
						next_eachnode = nodelist.keys()[0];
						label = nodelist[nodelist.keys()[0]];
						del nodelist[next_eachnode];
						#print  (next_eachnode, label)
						while(rrgraph.neighbors(next_eachnode)!=[]):
                		                	for nextnext_eachnode in rrgraph.neighbors(next_eachnode):
								#print next_eachnode, nextnext_eachnode
								labellist=[];
	                                                        for prevnode in rrgraph.incidents(next_eachnode):
        	                                                        labellist.append(rrgraph.edge_label((prevnode, next_eachnode)));
                	                                        #print "labellist:", labellist
								label = max(labellist);
								del labellist
                        		                	if(rrgraph.node_attributes(next_eachnode)[0][1] == 'logic'):
									label_level = label+8;
								else:	
									label_level = label+1;
								rrgraph.set_edge_label((next_eachnode, nextnext_eachnode), label_level);
								#print nodelist
                                		                #nodelist.append((nextnext_eachnode, label_level))
								#nodelist[nextnext_eachnode] = label_level;
								'''if(nextnext_eachnode in nodelist):
                                                                	if(nodelist[nextnext_eachnode]>label_level):
                                                                        	nodelist[nextnext_eachnode] = nodelist[nextnext_eachnode];
                                                                	else:
                                                                        	nodelist[nextnext_eachnode] = label_level;
                                                        	else:'''
                                                                nodelist[nextnext_eachnode] = label_level;
								#print nodelist
                                                	next_eachnode = nextnext_eachnode
							label = nodelist[nextnext_eachnode]
	                                                #nodelist.remove((nextnext_eachnode, label_level))
							del nodelist[nextnext_eachnode];
        	                                        #label = label_level

	#print nodelist
		
	'''
	#print rrgraph.edges()	
	for edge in rrgraph.edges():
		#print edge[0], edge[1], rrgraph.edge_label(edge)
		print"This edge:" edge
		for next_eachnode in rrgraph.neighbors(edge[1]):
			#print rrgraph.edge_label((edge[1], next_eachnode))
			rrgraph.set_edge_label((edge[1], next_eachnode), rrgraph.edge_label(edge)+1)
	'''

	#print  rrgraph
	outputgraph = open('rrgraph.dot','w');
	outputgraph.write(dot.write(rrgraph))
	outputgraph.close()

	compnodedict = {}
	for eachnode in rrgraph:
		if(rrgraph.incidents(eachnode)!=[]):
	                if(rrgraph.node_attributes(eachnode)[0][1] == 'logic'):
				iatlist = [];
                	        for prev_node in rrgraph.incidents(eachnode):
                        	        #print eachnode, rrgraph.edge_label((prev_node, eachnode))
					iatlist.append(rrgraph.edge_label((prev_node, eachnode)));
				compnodedict[eachnode] = max(iatlist) - min(iatlist);
				del iatlist;

	#print compnodedict
	print "MLI:                           ", max(compnodedict.values());			
	
	#print "Here is the output node and latency value:"
	latency_list = [];
	for eachnode in rrgraph:
		if(rrgraph.neighbors(eachnode)==[]):
			if(rrgraph.node_attributes(eachnode)[0][1] == 'logic'):
				for prev_node in rrgraph.incidents(eachnode):
					latency_list.append(rrgraph.edge_label((prev_node, eachnode)));

	print "Latency:                       ", max(latency_list)	
					#print eachnode, rrgraph.edge_label((prev_node, eachnode))


	#for eachnode in rrgraph:
	#	print eachnode, rrgraph.node_order(eachnode)
			
	

	'''global swithbox, nodes, clusters, IOs, params, clusterx, clustery
	for n in nets.values():
		#print 'net: ',n.name
		nodelist = []
		
		if n.source[0] in [0, clusterx] or n.source[1] in [0, clustery]:
			#edge, thee are IOS
			for input in IOs[tuple(n.source[0:2])].inputs:
				if input.index is n.source[2]:
					last_node = input.id
					break
		else:
			#cluster
			last_node = clusters[tuple(n.source[0:2])].outputs[n.source[2] - params.I].id
		nodelist.append(last_node)
	
		#print len(n.trace)
		for trace in n.trace:
	
	
	
			#find sbox or sink
			#[dir, x1,y1,x2,y2, channel])
			drivers = []
			

			if trace.type == 'X':
				#print trace[-1], len(switchbox[tuple(trace[1:3])].driversx)
				drivers = switchbox[tuple(trace.loc[0:2])].driversx
				
			elif trace.type == 'Y':
				drivers = switchbox[tuple(trace.loc[0:2])].driversy
			elif trace.type == 'SINK':

				
				if trace.loc[0] in [0, clusterx] or trace.loc[1] in [0, clustery]:
					#edge, these are IOS
					
					
					for output in IOs[trace.loc].outputs:
						if output.index is trace.index:
							output.source = last_node
							output.net = n.name
							nodes[output.id].source = last_node
							
							if last_node not in nodes[output.id].inputs:
								print 'error routing', output.id, last_node
							break
							
					
				else: #cluster	
					for input in clusters[trace.loc].inputs:
						if input.index is trace.index:
							if input.id  in nodes[last_node].edges:
							
								input.source = last_node
								input.net = n.name		
								nodes[input.id].source = last_node
							else:
								print n.name, trace.loc, input.index 
								print 'error node', last_node, input.id
								print nodelist
								assert(0)
				continue
			else: #SOURCE
				if trace.loc[0] in [0, clusterx] or trace.loc[1] in [0, clustery]:
					#edge, these are IOS
					found = False
					for input in IOs[trace.loc].inputs:
						if input.index is trace.index:
							input.net = n.name
							last_node = input.id
							found = True
							break
							
					if found == False:
						print 'Error finding FPGA input', n.name, 'at', trace.loc
				else:
					#cluster
					for output in clusters[tuple(trace.loc)].outputs:
						if output.index is trace.index:
							last_node = output.id
			
				continue
			#chanx or y 	
			for d in drivers:
				if d.index is trace.index:
					driver = d
					break
			if driver.id in nodelist:
				pass
			else:
				if driver.id  in nodes[last_node].edges:
					#success!
					driver.source = last_node
					driver.net = n.name
					nodes[driver.id].source = last_node
					
				else:
					print "error routing", last_node, driver.id, nodes[last_node].edges
				nodelist.append(driver.id)
			last_node = driver.id
		'''



def read_placement(filename):

        fh = open(filename,"r")

        line = fh.readline()
	print 'This is line 1!!'
        print line
        while len(line) > 0 :
                if line.split(' ')[0] == 'Array':
			#print 'Here I got the array line'
                        clusterx = (int)(line.split(' ')[2]);
			clustery = (int)(line.split(' ')[4]);
			print clusterx, clustery

                if line == '#----------	--	--	------	------------\n':
                        break
                line = fh.readline()
		print 'This is line 2!!'
                print line

        line = fh.readline()
	print 'This is line 3!!'
        print line
#	placement = [[]]
	placement = [[0 for i in xrange(clusterx+1)] for i in xrange(clustery+1)]
        #global clusters, placement, clusterx,clustery



        while len(line) > 0:
                entries = line.split()
                print entries
                #if 'i' in entries[0] or 'o' in entries[0]:
                '''if int( entries[1] )in [0, clusterx] or int( entries[2] ) in [0, clustery]:
                        pass #skip ios
                else:

                        #clusters[( int(entries[1] ), int( entries[2] )) ].CLB = entries[0] #name and location 
                '''
                placement[int(entries[1])][int(entries[2])] = entries[0]
	        line = fh.readline()
                print line

	for i in range(0, clusterx+1):
		print placement[i]

	return placement


#placement = read_placement('test.place.out');
read_routing('test.route.out');




