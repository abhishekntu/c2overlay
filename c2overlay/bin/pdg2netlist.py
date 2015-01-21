'''
Created on Dec 9, 2013
 
@author: abhishek013
'''
 
import pydot
import sys
import os

from pygraph.classes.graph import graph
from pygraph.classes.digraph import digraph
from pygraph.algorithms.searching import breadth_first_search
from pygraph.algorithms.searching import depth_first_search
from pygraph.algorithms.critical import transitive_edges
from pygraph.readwrite.dot import write
from pygraph.readwrite import dot


#Function to generate netlist of a given graph
def GenerateNetlist(graph, graphname):       
    #Creating Netlist file and writing inputs to netlist file. Format: 
    #.input N6
    #pinlist: N6     
    filename = r'%s.net' % (graphname)   
    wr_file = open(filename, 'w')
    inputcount = 0;    
    for each in graph:
            if graph.incidents(each) == []:
                inputcount = inputcount+1;
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
    end_node_list = [];
    outputcount = 0;
    for each in graph:            
            if graph.neighbors(each) == []: 
                outputcount = outputcount+1;
                end_node = each
                end_node_list.append(end_node);
                line = r""".output out:%s
""" % each
                wr_file.write(line)
                line = r"""pinlist: %s
    
""" % each
                wr_file.write(line)

    #print end_node_list                
    #Writing one block for each node in the graph. Format: 
    #.clb N8_blk
    #pinlist: N7 N6 open open N8 open open open open 
    #subblock: N8_blk 0 1 open open 4 open open open open  
    blockcount = 0;
    for each in graph:            
            if graph.incidents(each) != [] and graph.neighbors(each) != [] :
                blockcount = blockcount+1;
                #print 'for node', each, graph.incidents(each)
                line = r""".clb %s_blk
""" % each
                wr_file.write(line)
                line = r"""pinlist: """ 
                wr_file.write(line)             
                for node in graph.incidents(each):                                
                    line = r"""%s """ % node
                    wr_file.write(line) 
                for itera in range(0, 4-len(graph.incidents(each))): #previously it was 4 
                    line = r"""open """ 
                    wr_file.write(line)
        
                each_neighbors = graph.neighbors(each)
                endNodePrev = False
                for each_neighbor in each_neighbors:
                    if (each_neighbor in end_node_list):
                        endNodePrev = True
                        end_node = each_neighbor
                        break

                if(endNodePrev):
                    line = r"""%s """ % end_node
                else:   
                    line = r"""%s """ % each
                 
                wr_file.write(line)     
                for itera in range(0, 4):  #previously it was 4  
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
                  
#    print "Total nodes after tech-mapping:", blockcount+inputcount+outputcount	
#    print "I/O nodes:", inputcount,"/",outputcount
#    #print outputcount
#    print "Final OP nodes:", blockcount
    wr_file.close()          
    return [inputcount, outputcount]  
    #Netlist generated


# Read the dot file and create a graph
benchmark = sys.argv[1];
#command = 'dot -Tpng %s.dot > %s_original.png' % (benchmark, benchmark);
#os.system(command)    
filepath = r'%s.dot' % (benchmark)
inputfile  = open(filepath, 'r')
data = inputfile.read()
inputfile.close()
graph = dot.read(data)
my_graph = dot.read(data)
#print graph
#print "Total nodes:", len(graph.nodes())

for each in graph:
    graph.set_level(each, 0)
#---------------------------------------------------------------------------
#---------------------------------------------------------------------------
#scheduling starts here...
top_level_nodes = []
scheduled_nodes = []
unscheduled_nodes = graph.nodes()
sequencing_graph = []
l=1;
  
for node in graph:                      #for each node
    if graph.incidents(node) == []:     #if node is at the top level    
        graph.set_level(node, l)        #schedule the node by setting its level l = 1
        top_level_nodes.append(node)    #push this node in the list of top level nodes
        scheduled_nodes.append(node)    #push this node in the list of scheduled nodes
        unscheduled_nodes.remove(node)  #remove this node from the list of unscheduled nodes
          
#print 'All nodes   ----   ' , graph.nodes()     
#print 'Top level nodes ---' , scheduled_nodes
#print 'Unscheduled nodes -' , unscheduled_nodes
sequencing_graph.append(top_level_nodes)#push all top level nodes in sequencing graph
#print sequencing_graph
make_node_working = 1
  
while unscheduled_nodes != []:          #repeat while the list of unscheduled nodes gets empty    
#    print 'Iteration no. -----', l 
    working_nodes = []                  #initialize an empty list of nodes which will contain the next level nodes  
    l = l + 1
    make_node_working = 1
      
    for node in unscheduled_nodes:      #select a node from the list of unscheduled nodes
        predecesors = graph.incidents(node) #make a list of all precesessor nodes of this node 
        make_node_working = 1
        for predecessor in predecesors:     #check each predecessor node and check if all are scheduled      
            if predecessor in unscheduled_nodes:    
                make_node_working = 0
                  
        if(make_node_working == 1):         #if yes, then 
            working_nodes.append(node)      #push this node in the list of working nodes which contains nodes of level l+1
    #        if graph.check_level(predecessor) != 0:
    #            working_nodes.append(each) #do it for all nodes
                  
      
#    print 'Working nodes ---', working_nodes
    sequencing_graph.append(working_nodes)  #push next level of nodes into sequencing graph
    for node in working_nodes:              #
        graph.set_level(node,l)
        scheduled_nodes.append(node)
        unscheduled_nodes.remove(node)
#---------------------------------------------------------------------------
#---------------------------------------------------------------------------
#print sequencing_graph
#print graph.nodes()
#---------------------------------------------------------------------------
#---------------------------------------------------------------------------
# Template maching starts here
templates = ['muad', 'admu', 'adad', 'musu', 'adsu']
#print templates
# for level in sequencing_graph[0:len(sequencing_graph)-1]:
#     print level
#     for node in level:
#         print 'current node-', node
#         successors = graph.neighbors(node)
#         for successor in successors:
#             print 'current successor-', successor
#             if graph.check_level(successor)-1 == graph.check_level(node): 
#                 pattern = graph.node_attributes(node)[1][1][1] + graph.node_attributes(successor)[1][1][1]
#                 print node, successor, pattern
#                 if pattern in templates:
#                     graph.set_level(successor,graph.check_level(node)+0.1)
#                     sequencing_graph[graph.check_level(node)].remove(successor)
#                     print 'current s graph', sequencing_graph[graph.check_level(node)]
#             elif graph.check_level(successor)-2 == graph.check_level(node): 
#                 graph.set_level(node, graph.check_level(node)+1) 
#                 sequencing_graph[graph.check_level(node)-1].append(node)
#                 print 's graph', sequencing_graph[graph.check_level(node)]
#                 print graph.check_level(node)

new_graph = digraph();
                       
for level in sequencing_graph[0:len(sequencing_graph)-1]:
#    print level
    for node in level:
#        print 'current node-', node
        successors = graph.neighbors(node)
        for successor in successors:
#            print 'current successor-', successor
            if graph.check_level(successor)-1 == graph.check_level(node): 
                pattern = graph.node_attributes(node)[2][1][1:3] + graph.node_attributes(successor)[2][1][1:3]
#                print node, successor, pattern
                if pattern in templates:
                    new_graph.add_node(node);
#                    print graph.node_attributes(node)[2][0]
#                    print graph.node_attributes(each)[2][1] + node
		    #new_attr = node + successor + graph.node_attributes(node)[2][1] + graph.node_attributes(successor)[2][1];
		    label_node = graph.node_attributes(node)[2][1];
		    label_succ = graph.node_attributes(successor)[2][1];
		    #rint label_node, label_succ
		    new_attr = r'"%s%s_%s_%s"' % (node, successor, label_node[1:len(label_node)-1], label_succ[1:len(label_succ)-1])
		    #new_attr = ''.join([node, successor]);
		    #print new_attr		   
                    new_graph.add_node_attribute(node, (graph.node_attributes(node)[2][0], new_attr))
                    new_graph.set_next_node(node, successor)   
                    graph.set_level(successor,graph.check_level(node)+0.1)
                    sequencing_graph[graph.check_level(node)].remove(successor)
#                    print 'current s graph', sequencing_graph[graph.check_level(node)]
            elif graph.check_level(successor)-2 == graph.check_level(node): 
                graph.set_level(node, graph.check_level(node)+1) 
                sequencing_graph[graph.check_level(node)-1].append(node)
#                print 's graph', sequencing_graph[graph.check_level(node)]
#                print graph.check_level(node)
  
  
  
#print graph.nodes()
#print graph.edges()
list_of_edges = graph.edges();
#print 'printing edges'

list_of_newnodes = new_graph.nodes();
#print 'list'

#print list_of_newnodes

for node in new_graph:
    list_of_newnodes.append(new_graph.check_next_node(node))
    
#print list_of_newnodes    
    
for node in graph:
    for new_node in new_graph:
        if node == new_node:
#            print new_graph.node_attributes(new_node)[0]
            graph.add_node_attribute(node, new_graph.node_attributes(new_node)[0])
            graph.set_next_node(node, new_graph.check_next_node(node))

for node in graph:
    for new_node in new_graph:
        if node == new_node:
#            print node
#            print graph.check_next_node(node)         
            
            incident_nodes = graph.incidents(graph.check_next_node(node))
            neighbor_nodes = graph.neighbors(graph.check_next_node(node))
                           
            for neighbor in neighbor_nodes:
                graph.add_edge((node,neighbor), 1, "", [])
                
            for incident in incident_nodes:
                if len(incident_nodes) > 1 and incident != node:
                    if graph.has_edge((incident,node))==False: 
#                        print graph.has_edge((incident,node))
                        graph.add_edge((incident,node), 1, "", [])   
            graph.del_node(graph.check_next_node(node))
            
            
            
#making new graph by adding nodes
new_digraph = digraph()
# Add the node number information to the attributes in the dot file
node_num=1;
input_num=0;
output_num=0;
dictionary = {};
for each in graph:
    if((each != "node") & (each != "graph") & (each != "edge")):       
        ntype = graph.node_attributes(each)[1][1];
        lable = graph.node_attributes(each)[2][1];# 
        #print lable
        if(ntype == '"invar"'):                
                nodename = r'N%s' % (node_num);
		#print nodename
                dictionary[each]=nodename;
                new_digraph.add_node(nodename)
                count = len(graph.node_attributes(each));                
                label = graph.node_attributes(each)[count-1][1];
		label_new = r'"%s_%s"' % (label[1:len(label)-1], nodename);
                #label_new = label + nodename
                new_digraph.add_node_attribute(nodename, (graph.node_attributes(each)[2][0], label_new));
                new_digraph.add_node_attribute(nodename, ("color", '"black"'));
                node_num = node_num + 1;
                input_num = input_num + 1;   

for each in graph:
    if((each != "node") & (each != "graph") & (each != "edge")):       
        ntype = graph.node_attributes(each)[1][1];
        lable = graph.node_attributes(each)[2][1];#      
#        print lable[1:5] 
        if((ntype == '"operation"') & (lable[1:5] == 'load')):
#                print 'yes load'          
                nodename = r'N%s' % (node_num);
                dictionary[each]=nodename;
                new_digraph.add_node(nodename)
                count = len(graph.node_attributes(each));                
                label = graph.node_attributes(each)[count-1][1];
		label_new = r'"%s_%s"' % (label[1:len(label)-1], nodename);
#                label_new = label + nodename
                new_digraph.add_node_attribute(nodename, (graph.node_attributes(each)[2][0], label_new));
                new_digraph.add_node_attribute(nodename, ("color", '"black"'));
                node_num = node_num + 1;
                
for each in graph:
    if((each != "node") & (each != "graph") & (each != "edge")):       
        ntype = graph.node_attributes(each)[1][1];
        lable = graph.node_attributes(each)[2][1];#  
#        print lable[1:6]     
        if((ntype == '"operation"') & (lable[1:5] != 'load') & (lable[1:6] != 'store')):  
                nodename = r'N%s' % (node_num);
                dictionary[each]=nodename;
                new_digraph.add_node(nodename)
                count = len(graph.node_attributes(each));                
                label = graph.node_attributes(each)[count-1][1];
		label_new = r'"%s_%s"' % (label[1:len(label)-1], nodename);	
                #label_new = label + nodename
                new_digraph.add_node_attribute(nodename, (graph.node_attributes(each)[2][0], label_new));
                new_digraph.add_node_attribute(nodename, ("color", '"black"'));
                node_num = node_num + 1;
                 
for each in graph:
    if((each != "node") & (each != "graph") & (each != "edge")):       
        ntype = graph.node_attributes(each)[1][1];
        lable = graph.node_attributes(each)[2][1];# 
#        print lable[1:6]      
        if((ntype == '"operation"') & (lable[1:6] == 'store')):
                nodename = r'N%s' % (node_num);
                dictionary[each]=nodename;
                new_digraph.add_node(nodename)
                count = len(graph.node_attributes(each));                
                label = graph.node_attributes(each)[count-1][1];
                label_new = r'"%s_%s"' % (label[1:len(label)-1], nodename);
		#label_new = label + nodename
                new_digraph.add_node_attribute(nodename, (graph.node_attributes(each)[2][0], label_new));
                new_digraph.add_node_attribute(nodename, ("color", '"black"'));
                node_num = node_num + 1;
     
for each in graph:
    if((each != "node") & (each != "graph") & (each != "edge")):       
        ntype = graph.node_attributes(each)[1][1];
        lable = graph.node_attributes(each)[2][1];# 
#        print lable      
        if(ntype == '"outvar"'):
                nodename = r'N%s' % (node_num);
                dictionary[each]=nodename;
                new_digraph.add_node(nodename)
                count = len(graph.node_attributes(each));                
                label = graph.node_attributes(each)[count-1][1];
                label_new = r'"%s_%s"' % (label[1:len(label)-1], nodename);
		#label_new = label + nodename
                new_digraph.add_node_attribute(nodename, (graph.node_attributes(each)[2][0], label_new));
                new_digraph.add_node_attribute(nodename, ("color", '"black"'));
                node_num = node_num + 1;
                output_num = output_num + 1;
    
for each in graph:
    if((graph.neighbors(each) != [])):
        for each_neighbor in graph.neighbors(each):
#            print dictionary[each];
            src = dictionary[each];
#            print src
#            print dictionary[each_neighbor];
            dst = dictionary[each_neighbor];
            #print dst
            new_digraph.add_edge((src, dst));    


filepath = r'%s.dot' % (benchmark)
outputfile  = open(filepath, 'w')
outputfile.write(dot.write(new_digraph))
outputfile.close()

[input_num, output_num] = GenerateNetlist(new_digraph, benchmark);
op_nodes = len(my_graph.nodes()) - (input_num+output_num);
op_nodes_tech_mapped = len(new_digraph.nodes()) - (input_num+output_num);
print "---------------------------------------"
#print "Graph nodes:			", my_graph.nodes();
#print "Mapped-Graph nodes:		", new_digraph.nodes();            
print "Total nodes:       		", len(my_graph.nodes());
print "I/O nodes:                  	", input_num, "/", output_num;
print "OP nodes:			", op_nodes;
print "OP nodes after tech-mapping:	", op_nodes_tech_mapped;
print "% Savings:			", 100*(op_nodes - op_nodes_tech_mapped)/op_nodes, "%";
#rint "---------------------------------------"
#GenerateNetlist(new_digraph, benchmark);    





