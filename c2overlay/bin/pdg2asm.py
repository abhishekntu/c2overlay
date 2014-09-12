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
#command = 'dot -Tpng %s.dot > %s_original.png' % (benchmark, benchmark);
#os.system(command)    
filepath = r'%s.dot' % (benchmark)
inputfile  = open(filepath, 'r')
data = inputfile.read()
inputfile.close()
graph = dot.read(data)
print graph

# Add the node number information to the attributes in the dot file
#for each in graph:
#    graph.add_node_attribute(each, (graph.node_attributes(each)[1][0], graph.node_attributes(each)[1][1]))
dict_map = {};
dict_map["mul"]=1;
dict_map["add"]=2;
dict_map["sub"]=2;
    
outfilename_dfg = r'%s.s' % (benchmark)
outfilename_io  = r'%s.txt' % (benchmark)
outputfile_dfg  = open(outfilename_dfg, 'w')
outputfile_io   = open(outfilename_io, 'w')

for each in graph:
	if((graph.incidents(each)!=[]) & (graph.neighbors(each)!=[])):
		num = each[1:len(each)]
		optype = graph.node_attributes(each)[1][1][1:4]
		#print op
		print each, dict_map[optype]
		parents = graph.incidents(each)
		srclen = len(parents)
		#print srclen
		if(srclen==1):
			src1 = parents[0][1:len(parents[0])]
			src2 = 0
			src3 = 0
		elif(srclen==2):
			src1 = parents[0][1:len(parents[0])]
			src2 = parents[1][1:len(parents[1])]
			src3 = 0
		#print "src1", src1, "src2", src2, "src3", src3
		line = "%s %s %s %s %s\n" % (num, dict_map[optype], src1, src2, src3)
		outputfile_dfg.write(line)
	elif(graph.incidents(each)==[]):
		num = each[1:len(each)]
		addr = 0
		data = 5
		io = 0
		reserved = 0		
		line = "%s %s %s %s %s\n" % (num, addr, data, io, reserved)
		outputfile_io.write(line)
	elif(graph.neighbors(each)==[]):
		node = graph.incidents(each)[0]
                num = node[1:len(each)]
                addr = 0
                data = 5
                io = 1
                reserved = 0
                line = "%s %s %s %s %s\n" % (num, addr, data, io, reserved)
                outputfile_io.write(line)
		


outputfile_dfg.close()
outputfile_io.close()
#command = 'dot -Tpng %s.dot > %s_nodenumber.png' % (benchmark, benchmark);
#os.system(command)    
#print graph

#generate VPR compatible netlist of the graph 
#GenerateNetlist(graph, benchmark);    
