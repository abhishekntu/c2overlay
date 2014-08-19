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


#Function to generate netlist of a given graph
def GenerateNetlist(graph, graphname):       
    #Creating Netlist file and writing inputs to netlist file. Format: 
    #.input N6
    #pinlist: N6     
    filename = r'%s.net' % (graphname)   
    wr_file = open(filename, 'w')
    for each in graph:
            if graph.incidents(each) == []:
                line = r""".input %s
""" % each
                wr_file.write(line)
                line = r"""pinlist: %s
    
""" % each
                wr_file.write(line)
              
    #Writing outputs of the graph to netlist file. Format: 
    #.output out:N6
    #pinlist: N6        
    # Note here assumption is that graph does have only single output which is "end_node"
    for each in graph:            
            if graph.neighbors(each) == []: 
                end_node = each
                line = r""".output out:%s
""" % each
                wr_file.write(line)
                line = r"""pinlist: %s
    
""" % each
                wr_file.write(line)
                
    #Writing one block for each node in the graph. Format: 
    #.clb N8_blk
    #pinlist: N7 N6 open open N8 open open open open 
    #subblock: N8_blk 0 1 open open 4 open open open open  
    for each in graph:            
            if graph.incidents(each) != [] and graph.neighbors(each) != [] :
                print 'for node', each, graph.incidents(each)
                line = r""".clb %s_blk
""" % each
                wr_file.write(line)
                line = r"""pinlist: """ 
                wr_file.write(line)             
                for node in graph.incidents(each):                                
                    line = r"""%s """ % node
                    wr_file.write(line) 
                for itera in range(0, 4-len(graph.incidents(each))):
                    line = r"""open """ 
                    wr_file.write(line)
                
                if(end_node in graph.neighbors(each)):
                    line = r"""%s """ % end_node
                else:   
                    line = r"""%s """ % each
                 
                wr_file.write(line)     
                for itera in range(0, 4):  
                    line = r"""open """ 
                    wr_file.write(line)  
                
                line = r"""
subblock: %s_blk """ % each 
                wr_file.write(line) 
                if len(graph.incidents(each)) == 1:
                    line = r"""0 open open open 4 open open open open
                    
"""  
                    wr_file.write(line)
                elif len(graph.incidents(each)) == 2:
                    line = r"""0 1 open open 4 open open open open
    
"""  
                    wr_file.write(line)
                elif len(graph.incidents(each)) == 3:
                    line = r"""0 1 2 open 4 open open open open
    
"""  
                    wr_file.write(line)               
                  
    wr_file.close()            
    #Netlist generated

 
# Read the dot file and create a graph
benchmark = sys.argv[1];
command = 'dot -Tpng %s.dot > %s_original.png' % (benchmark, benchmark);
os.system(command)    
filepath = r'%s.dot' % (benchmark)
inputfile  = open(filepath, 'r')
data = inputfile.read()
inputfile.close()
graph = dot.read(data)
print graph

# Add the node number information to the attributes in the dot file
for each in graph:
    graph.add_node_attribute(each, (graph.node_attributes(each)[1][0], graph.node_attributes(each)[1][1]))
    
outputfile  = open(filepath, 'w')
outputfile.write(dot.write(graph))
outputfile.close()
command = 'dot -Tpng %s.dot > %s_nodenumber.png' % (benchmark, benchmark);
os.system(command)    
print graph

#generate VPR compatible netlist of the graph 
GenerateNetlist(graph, benchmark);    
