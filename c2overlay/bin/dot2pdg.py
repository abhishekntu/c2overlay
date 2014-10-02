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



# Read the dot file and create a graph
benchmark = sys.argv[1];
command = 'dot -Tpng %s.dot > %s_original.png' % (benchmark, benchmark);
os.system(command)    
filepath = r'%s.dot' % (benchmark)
inputfile  = open(filepath, 'r')
data = inputfile.read()
inputfile.close()
graph = dot.read(data)
#print graph


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




#making new graph by adding nodes
new_graph = digraph()
# Add the node number information to the attributes in the dot file
node_num=1;
input_num=0;
output_num=0;
dictionary = {};
for each in graph:
    if((each != "node") & (each != "graph") & (each != "edge")):
#       print graph.node_attributes(each)[4][1]
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
	                print value
			label = graph.node_attributes(Immopnode)[6][1];
			print label
	                label_new = r'"%s_Imm_%s_%s"' % (label[1:len(label)-1], value[1:len(value)-1], nodename);
        	        new_graph.add_node_attribute(nodename, (graph.node_attributes(each)[6][0], label_new));
                	#new_graph.add_node_attribute(nodename, ("parents", graph.incidents(each)));
	                node_num = node_num + 1;

print dictionary

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
	









filepath = r'%s_new.dot' % (benchmark)    
outputfile  = open(filepath, 'w')
outputfile.write(dot.write(new_graph))
outputfile.close()
command = 'dot -Tpng %s_new.dot > %s_nodenumber.png' % (benchmark, benchmark);
os.system(command)    
print new_graph

#generate VPR compatible netlist of the graph 
#enerateNetlist(graph, benchmark);    
