'''
Created on Dec 9, 2013
 
@author: abhishek013
''' 
import pydot
import sys
from pygraph.classes.graph import graph
from pygraph.classes.digraph import digraph
from pygraph.algorithms.searching import breadth_first_search
from pygraph.algorithms.searching import depth_first_search
from pygraph.algorithms.critical import transitive_edges
from pygraph.readwrite.dot import write
from pygraph.readwrite import dot
import os

def create_graph(graph, new_graph, node_num, input_num, output_num):
	#making new graph by adding nodes
	#ew_graph = digraph()
	# Add the node number information to the attributes in the dot file
	#node_num=1;
	#input_num=0;
	#output_num=0;
	dictionary = {};
	for each in graph:
		if((each != "node") & (each != "graph") & (each != "edge")):
		#       print graph.node_attributes(each)
			ntype = graph.node_attributes(each)[4][1];
			lable = graph.node_attributes(each)[6][1];
		#       print ntype
			if(ntype == '"invar"'):
				#print graph.node_attributes(each)
				nodename = r'N%s' % (node_num);
				dictionary[each]=nodename;
				new_graph.add_node(nodename)
				label = graph.node_attributes(each)[6][1];
				#print label
				label_new = r'"I%s_%s"' % (input_num, nodename)
				new_graph.add_node_attribute(nodename, (graph.node_attributes(each)[6][0], label_new));
				new_graph.add_node_attribute(nodename, ("color", '"black"'));
				new_graph.add_node_attribute(nodename, (graph.node_attributes(each)[4][0], graph.node_attributes(each)[4][1]))
				#new_graph.add_node_attribute(nodename, ("parents", graph.incidents(each)));
				node_num = node_num + 1;
				input_num = input_num + 1;
	for each in graph:
		if((each != "node") & (each != "graph") & (each != "edge")):
		#	print graph.node_attributes(each)[4][1]
			ntype = graph.node_attributes(each)[4][1];
		#	print ntype
			lable = graph.node_attributes(each)[6][1];
			if((ntype == '"operation"') & (lable == '"load"')): 
				#print graph.node_attributes(each)
				nodename = r'N%s' % (node_num);
				dictionary[each]=nodename;
				new_graph.add_node(nodename)
				label = graph.node_attributes(each)[6][1];
				#print label
				label_new = r'"%s_%s"' % (label[1:len(label)-1], nodename)
				new_graph.add_node_attribute(nodename, (graph.node_attributes(each)[6][0], label_new));
				new_graph.add_node_attribute(nodename, ("color", '"black"'));
				new_graph.add_node_attribute(nodename, (graph.node_attributes(each)[4][0], graph.node_attributes(each)[4][1]))
				node_num = node_num + 1;

	for each in graph:
		if((each != "node") & (each != "graph") & (each != "edge")):
		#       print graph.node_attributes(each)[4][1]
			ntype = graph.node_attributes(each)[4][1];
		#       print ntype
			lable = graph.node_attributes(each)[6][1];
			if((ntype == '"operation"') & (lable != '"load"') & (lable != '"store"')):
				#print graph.node_attributes(each)
				nodename = r'N%s' % (node_num);
				dictionary[each]=nodename;
				new_graph.add_node(nodename)
				label = graph.node_attributes(each)[6][1];
				#print label
				label_new = r'"%s_%s"' % (label[1:len(label)-1], nodename)
				new_graph.add_node_attribute(nodename, (graph.node_attributes(each)[6][0], label_new));
				new_graph.add_node_attribute(nodename, ("color", '"black"'));
				new_graph.add_node_attribute(nodename, (graph.node_attributes(each)[4][0], graph.node_attributes(each)[4][1]))
				node_num = node_num + 1;

	for each in graph:
		if((each != "node") & (each != "graph") & (each != "edge")):
		#       print graph.node_attributes(each)[4][1]
			ntype = graph.node_attributes(each)[4][1];
		#       print ntype
			lable = graph.node_attributes(each)[6][1];
			if((ntype == '"operation"') & (lable == '"store"')):
				#print graph.node_attributes(each)
				nodename = r'N%s' % (node_num);
				dictionary[each]=nodename;
				new_graph.add_node(nodename)
				label = graph.node_attributes(each)[6][1];
				#print label
				label_new = r'"%s_%s"' % (label[1:len(label)-1], nodename)
				new_graph.add_node_attribute(nodename, (graph.node_attributes(each)[6][0], label_new));
				new_graph.add_node_attribute(nodename, ("color", '"black"'));
				new_graph.add_node_attribute(nodename, (graph.node_attributes(each)[4][0], graph.node_attributes(each)[4][1]))
				node_num = node_num + 1;

	for each in graph:
		if((each != "node") & (each != "graph") & (each != "edge")):
		#       print graph.node_attributes(each)[4][1]
			ntype = graph.node_attributes(each)[4][1];
		#       print ntype
			if(ntype == '"outvar"'):
				#print graph.node_attributes(each)
				nodename = r'N%s' % (node_num);
				dictionary[each]=nodename;
				new_graph.add_node(nodename)
				label = graph.node_attributes(each)[6][1];
				#print label
				label_new = r'"O%s_%s"' % (output_num, nodename)
				new_graph.add_node_attribute(nodename, (graph.node_attributes(each)[6][0], label_new));
				new_graph.add_node_attribute(nodename, ("color", '"black"'));
				new_graph.add_node_attribute(nodename, (graph.node_attributes(each)[4][0], graph.node_attributes(each)[4][1]))
				#new_graph.add_node_attribute(nodename, ("parents", graph.incidents(each)));
				node_num = node_num + 1;
				output_num = output_num + 1;

	for each in graph:
		if((each != "node") & (each != "graph") & (each != "edge")):
		#       print graph.node_attributes(each)[4][1]
			ntype = graph.node_attributes(each)[4][1];
		#       print ntype
			if(ntype == '"constant"'):
				#print graph.node_attributes(each)
				#nodename = r'N%s' % (node_num);
				for Immopnode in graph.neighbors(each):
					#Immopnode = graph.neighbors(each)[0]
					nodename = dictionary[Immopnode]
					#dictionary[each]=nodename;
					#new_graph.add_node(nodename)
					value = graph.node_attributes(each)[6][1];
					#print value
					label = graph.node_attributes(Immopnode)[6][1];
					#print label
					label_new = r'"%s_Imm_%s_%s"' % (label[1:len(label)-1], value[1:len(value)-1], nodename);
					new_graph.add_node_attribute(nodename, (graph.node_attributes(each)[6][0], label_new));
					new_graph.add_node_attribute(nodename, (graph.node_attributes(Immopnode)[4][0], graph.node_attributes(Immopnode)[4][1]))
					#new_graph.add_node_attribute(nodename, ("parents", graph.incidents(each)));
					node_num = node_num + 1;

	#print dictionary
	# connecting edges between nodes of new_graph based on original graph

	for each in graph:
		if((each != "node") & (each != "graph") & (each != "edge")):
			if((graph.neighbors(each) != []) & (graph.node_attributes(each)[4][1] != '"constant"')):
				for each_neighbor in graph.neighbors(each):
					#print dictionary[each];
					src = dictionary[each];
					#print src
					#print dictionary[each_neighbor];
					dst = dictionary[each_neighbor];
					#print dst
					new_graph.add_edge((src, dst));

	return [new_graph, node_num, input_num, output_num]

	#print new_graph.nodes()	

	#print "Total nodes:", len(new_graph.nodes())



# Read the dot file and create a graph
benchmark = sys.argv[1];
#command = 'dot -Tpng %s.dot > %s_original.png' % (benchmark, benchmark);
#os.system(command)    
filepath = r'%s.dot' % (benchmark)
inputfile  = open(filepath, 'r')
data = inputfile.read()
inputfile.close()
graph = dot.read(data)
#print graph


#making a dictionary of load and its incidents
loadlist = {}
for each in graph:
        if((each != "node") & (each != "graph") & (each != "edge")):
                ntype = graph.node_attributes(each)[4][1];
#               print ntype
                lable = graph.node_attributes(each)[6][1];
                if((ntype == '"operation"') & (lable == '"load"')):
                        loadlist[each] = graph.incidents(each)

for loads in loadlist:
	loadlist[loads].sort();
#print lodelist
for loads in loadlist:
	loadlist[loads] = loadlist[loads][0] + loadlist[loads][1]

constlist = {};
for k, v in loadlist.iteritems():
	constlist[v] = constlist.get(v, [])
	constlist[v].append(k)
#print "Here is the constlist:"
#print constlist.values()

for myloadlist in constlist.values():
	myload = myloadlist.pop();
	#print myload	
	for each in myloadlist:
		for each_next in graph.neighbors(each):
			graph.add_edge((myload, each_next));
		graph.del_node(each)	




#cleaning graph: retaining only operation, invar and outvar nodes
for each in graph:
	if((each != "node") & (each != "graph") & (each != "edge")): 
		ntype = graph.node_attributes(each)[4][1];
		if((ntype != '"operation"') & (ntype != '"invar"') & (ntype != '"outvar"') & (ntype != '"constant"')):
			graph.del_node(each)

#print graph

#merging load and mov into one load
for each in graph:
        if((each != "node") & (each != "graph") & (each != "edge")):
                ntype = graph.node_attributes(each)[6][1];
                if((ntype == '"mov"')):
			for each_neighbor in graph.neighbors(each):
				#print graph.incidents(each)[0]
				#print each_neighbor
                        	graph.add_edge((graph.incidents(each)[0], each_neighbor))
		#graph.del_node(each)
				

#removing mov node
for each in graph:
        if((each != "node") & (each != "graph") & (each != "edge")):
                ntype = graph.node_attributes(each)[6][1];
                if((ntype == '"mov"')):
                        graph.del_node(each)

#merging constant and ldc into one load
for each in graph:
        if((each != "node") & (each != "graph") & (each != "edge")):
                ntype = graph.node_attributes(each)[6][1];
                if((ntype == '"ldc"')):
                        for each_neighbor in graph.neighbors(each):
                                #print graph.incidents(each)[0]
                                #print each_neighbor
                                graph.add_edge((graph.incidents(each)[0], each_neighbor))
                #graph.del_node(each)


#removing mov node
for each in graph:
        if((each != "node") & (each != "graph") & (each != "edge")):
                ntype = graph.node_attributes(each)[6][1];
                if((ntype == '"ldc"') | (ntype == '"jmpun"') | (ntype == '"nop"')):
                        graph.del_node(each)

#making a dictionary of load and its incidents
'''lodelist = {}
for each in graph:
	if((each != "node") & (each != "graph") & (each != "edge")):
		ntype = graph.node_attributes(each)[4][1];
#       	print ntype
        	lable = graph.node_attributes(each)[6][1];
        	if((ntype == '"operation"') & (lable == '"load"')):
			lodelist[each] = graph.incidents(each)

print lodelist

'''

new_graph = digraph()
node_num=1;
input_num=0;
output_num=0;

multiple = int(sys.argv[2]);
for count in range(0, multiple):
	[new_graph, node_num, input_num, output_num] = create_graph(graph, new_graph, node_num, input_num, output_num)


mydict = {}
optypelist = ['mul', 'add' , 'sub', 'sqr', 'muladd', 'mulsub', 'addmul', 'submul', 'addadd', 'addsub', 'subadd', 'subsub', 'addmuladd', 'addmulsub', 'submuladd', 'submulsub', 'sqradd', 'sqrsub']
for eachoptype in optypelist:
	mydict[eachoptype]=0;

'''mydict['mul']=0;
mydict['add']=0;
mydict['sub']=0;
mydict['sqr']=0;
mydict['muladd']=0;
mydict['mulsub']=0;
'''



oplist = [];
#print new_graph
for each in new_graph:
	optype = new_graph.node_attributes(each)[0][1][1:4];
	if((optype[0] != 'I') & (optype[0] != 'O') & (optype != 'sto') & (optype != 'loa')): 
#	print new_graph.node_attributes(each)[0][1][1:4]
		oplist.append(new_graph.node_attributes(each)[0][1][1:4]);
		if(optype in mydict):
			mydict[optype] += 1;

	for child in new_graph.neighbors(each):
		optype_2 = optype + new_graph.node_attributes(child)[0][1][1:4];
		#print optype_2
		if(optype_2 in mydict):
			mydict[optype_2] += 1;
		for childofchild in new_graph.neighbors(child):
			optype_3 = optype_2 + new_graph.node_attributes(childofchild)[0][1][1:4];
			if(optype_3 in mydict):
				mydict[optype_3] += 1;
 


print mydict

'''oplistset = set(oplist)
while(oplistset != set()):
	optype = oplistset.pop();
	print optype, oplist.count(optype) 
'''


filepath = r'%s_new.dot' % (benchmark)    
outputfile  = open(filepath, 'w')
data1 = dot.write(new_graph)
#print data1
outputfile.write(data1)
#utputfile.write(dot.write(new_graph))
outputfile.close()
#command = 'dot -Tpng %s_new.dot > %s_nodenumber.png' % (benchmark, benchmark);
#os.system(command)    
#print new_graph

#generate VPR compatible netlist of the graph 
#enerateNetlist(graph, benchmark);    
