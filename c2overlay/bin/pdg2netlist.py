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
from collections import defaultdict


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

                elif len(graph.incidents(each)) == 4:
                    line = r"""0 1 2 3 4 open open open open

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

def find_patterns(optypelist, new_graph):
    #print "-----------------------------"
    #print "----Finding patterns----"
    #print "-----------------------------"
    mydict = defaultdict(list)
    for eachoptype in optypelist:
        mydict[eachoptype]=[[]];

    oplist = [[]];
    onenodelist=[];
    twonodelist=[];
    threenodelist=[];

    for each in new_graph:
        optype = new_graph.node_attributes(each)[2][1][1:4];
        if((optype[0] != 'I') & (optype[0] != 'O') & (optype != 'sto') & (optype != 'loa')):
            #print new_graph.node_attributes(each)
            oplist.append(new_graph.node_attributes(each)[2][1][1:4]);
            if(optype in mydict):
                #print each
                onenodelist=[];
                onenodelist.append(each)
                mydict[optype].append(onenodelist)
        if(len(new_graph.neighbors(each))<=1):
            for child in new_graph.neighbors(each):
                optype_2 = optype + new_graph.node_attributes(child)[2][1][1:4];
                #print optype_2
                if(optype_2 in mydict):
                    twonodelist=[];
                    twonodelist.append(each);
                    twonodelist.append(child);
                    mydict[optype_2].append(twonodelist);


                if(len(new_graph.neighbors(child))<=1):
                    for childofchild in new_graph.neighbors(child):
                        optype_3 = optype_2 + new_graph.node_attributes(childofchild)[2][1][1:4];
                        if(optype_3 in mydict):
                            threenodelist=[];
                            threenodelist.append(each);
                            threenodelist.append(child);
                            threenodelist.append(childofchild)
                            mydict[optype_3].append(threenodelist);


    for eachoptype in optypelist:
        mydict[eachoptype].pop(0)
        #print eachoptype, len(mydict[eachoptype]), mydict[eachoptype]
    #print mydict.items()
    return mydict

def find_patterns_second_round(optypelist, new_graph, segmentlist):
    #print "-----------------------------"
    #print "----Finding patterns----"
    #print "-----------------------------"
    mydict = defaultdict(list)
    for eachoptype in optypelist:
        mydict[eachoptype]=[[]];

    oplist = [[]];
    onenodelist=[];
    twonodelist=[];
    threenodelist=[];
    for each in new_graph:
        if not [sub_list for sub_list in segmentlist if each in sub_list]:
            optype = new_graph.node_attributes(each)[2][1][1:4];
            if((optype[0] != 'I') & (optype[0] != 'O') & (optype != 'sto') & (optype != 'loa')):
                #print new_graph.node_attributes(each)
                oplist.append(new_graph.node_attributes(each)[2][1][1:4]);
                if(optype in mydict):
                    #print each
                    onenodelist=[];
                    onenodelist.append(each)
                    mydict[optype].append(onenodelist)
            if(len(new_graph.neighbors(each))<=1):
                for child in new_graph.neighbors(each):
                    if not [sub_list for sub_list in segmentlist if child in sub_list]:
                        optype_2 = optype + new_graph.node_attributes(child)[2][1][1:4];
                        #print optype_2
                        if(optype_2 in mydict):
                            twonodelist=[];
                            twonodelist.append(each);
                            twonodelist.append(child);
                            mydict[optype_2].append(twonodelist);


                        if(len(new_graph.neighbors(child))<=1):
                            for childofchild in new_graph.neighbors(child):
                                if not [sub_list for sub_list in segmentlist if childofchild in sub_list]:
                                    optype_3 = optype_2 + new_graph.node_attributes(childofchild)[2][1][1:4];
                                    if(optype_3 in mydict):
                                        threenodelist=[];
                                        threenodelist.append(each);
                                        threenodelist.append(child);
                                        threenodelist.append(childofchild)
                                        mydict[optype_3].append(threenodelist);


    for eachoptype in optypelist:
        mydict[eachoptype].pop(0)
        #print eachoptype, len(mydict[eachoptype]), mydict[eachoptype]
    #print mydict.items()
    return mydict

def getvalidsegmentlist(optypelist, mydict, numnodes):
    #print "-----------------------------"
    #print "----Here are the segments----"
    #print "-----------------------------"

    segmentdict = {}
    segmentlist = []

    for eachoptype in optypelist:
        if len(eachoptype) == numnodes*3:
            for eachsegment in mydict[eachoptype]:
                #print eachsegment
                segmentlist.append(eachsegment)
                segmentdict[eachsegment[0]]=0;

    #print "-----------------------------"
    #print "----find max overlap---------"
    #print "-----------------------------"
    for eachsegment in segmentlist:
        #print "For the segment:", eachsegment, "Here are the overlapped segments:"
        for samplesegment in segmentlist:
            if [i for i in eachsegment if i in samplesegment]:
                #print samplesegment
                segmentdict[eachsegment[0]] += 1;
                #if segmentdict[eachsegment[0]] > 2:
                #    segmentlist.remove(eachsegment)

    #print segmentdict
    #print segmentlist
    #print max(segmentdict.values())
    maxoverlap = max(segmentdict.values());
    num_iterations = max(segmentdict.values());

    #print "-----------------------------"
    #print "----iterating over segments--"
    #print "-----------------------------"

    for iterator in range(1, num_iterations):
        #print "iteration number -- ", iterator
        maxoverlap = maxoverlap - 1;
        segmentdict = dict.fromkeys(segmentdict.iterkeys(), 0)
        for eachsegment in segmentlist:
            #print "For the segment:", eachsegment, "Here are the overlapped segments:"
            for samplesegment in segmentlist:
                if [i for i in eachsegment if i in samplesegment]:
                    #print samplesegment
                    segmentdict[eachsegment[0]] += 1;
                    if segmentdict[eachsegment[0]] > maxoverlap:
                        segmentlist.remove(samplesegment)

        #print segmentdict
        #print segmentlist
    return segmentlist

#chebyshev_pdg
#sgfilter_pdg
#mibench_pdg
#qspline_pdg
#poly1_pdg
#poly2_pdg
#poly3_pdg
#poly4_pdg
#atax_pdg
#bicg_pdg
#gesummv_pdg
#syrk_pdg
#trmm_pdg



benchmark = sys.argv[1];
#command = 'dot -Tpng %s.dot > %s_original.png' % (benchmark, benchmark);
#os.system(command)
filepath = r'%s.dot' % (benchmark)
inputfile  = open(filepath, 'r')
data = inputfile.read()
inputfile.close()
graph = dot.read(data)
my_graph = dot.read(data)
new_graph = dot.read(data)

#command = 'dot -Tpng %s.dot > %s.png' % (benchmark, benchmark)
#os.system(command)




optypelist = ['mul', 'add' , 'sub', 'sqr', 'muladd', 'mulsub', 'addmul', 'submul', 'addadd', 'addsub', 'subadd', 'subsub', 'addmuladd', 'addmulsub', 'submuladd', 'submulsub', 'sqradd', 'sqrsub']
mydict = find_patterns(optypelist, new_graph)

'''
print "-----------------------------"
print "----Here are the segments----"
print "-----------------------------"
'''

segmentdict = {}
segmentlist = []

for eachoptype in optypelist:
    if len(eachoptype) == 9:
        for eachsegment in mydict[eachoptype]:
            #print eachsegment
            segmentlist.append(eachsegment)
            segmentdict[eachsegment[0]]=0;

flag_three_node = 1;

if not segmentlist:
    #print "No pattern for combining three nodes..."
    flag_three_node = 0;
    threenode_segmentlist = segmentlist;
    mydict = find_patterns_second_round(optypelist, new_graph, segmentlist);
    twonode_segmentlist = getvalidsegmentlist(optypelist, mydict, 2);
else:
    segmentlist = getvalidsegmentlist(optypelist, mydict, 3);
    threenode_segmentlist = segmentlist;
    mydict = find_patterns_second_round(optypelist, new_graph, segmentlist);
    twonode_segmentlist = getvalidsegmentlist(optypelist, mydict, 2);


onenode_segmentlist = [[]];

for each in new_graph:
    if not [sub_list for sub_list in twonode_segmentlist if each in sub_list]:
        if not [sub_list for sub_list in threenode_segmentlist if each in sub_list]:
            optype = new_graph.node_attributes(each)[2][1][1:4];
            if((optype[0] != 'I') & (optype[0] != 'O') & (optype != 'sto') & (optype != 'loa')):
                #print each
                onenodelist = [];
                onenodelist.append(each)
                onenode_segmentlist.append(onenodelist)

onenode_segmentlist.pop(0)


'''
if(flag_three_node):
    print "three node segment list:"
    print threenode_segmentlist, threenode_segmentlist[0][len(threenode_segmentlist[0])-1]
print "two node segment list:"
print twonode_segmentlist
print "one node segment list:"
print onenode_segmentlist

print "-----------------------------"
print "--creation of segment graph--"
print "-----------------------------"
'''

segmentgraph = digraph();
if(flag_three_node):
    for eachsegment in threenode_segmentlist:
        node = eachsegment[0]
        segmentgraph.add_node(node)
        #print graph.node_attributes(node)[2][1]
        label_node = graph.node_attributes(node)[2][1]
        child =  graph.neighbors(node)
        childofchild =  graph.neighbors(child[0])
        label_child = graph.node_attributes(child[0])[2][1]
        label_childofchild = graph.node_attributes(childofchild[0])[2][1]
        #print child[0], label_child, childofchild[0], label_childofchild
        new_attr = r'"%s%s%s_%s_%s_%s"' % (node, child[0], childofchild[0], label_node[1:len(label_node)-1], label_child[1:len(label_child)-1], label_childofchild[1:len(label_childofchild)-1])
        #print new_attr
        segmentgraph.add_node_attribute(node, (graph.node_attributes(node)[2][0], new_attr))


for eachsegment in twonode_segmentlist:
    node = eachsegment[0]
    segmentgraph.add_node(node)
    #print graph.node_attributes(node)[2][1]
    label_node = graph.node_attributes(node)[2][1]
    child = graph.neighbors(node)
    label_child = graph.node_attributes(child[0])[2][1]
    #print child[0], label_child
    new_attr = r'"%s%s_%s_%s"' % (node, child[0], label_node[1:len(label_node)-1], label_child[1:len(label_child)-1])
    #print new_attr
    segmentgraph.add_node_attribute(node, (graph.node_attributes(node)[2][0], new_attr))


for eachsegment in onenode_segmentlist:
    node = eachsegment[0]
    segmentgraph.add_node(node)
    #print graph.node_attributes(node)[2][1]
    label_node = graph.node_attributes(node)[2][1]
    new_attr = r'"%s_%s"' % (node, label_node[1:len(label_node)-1])
    #print new_attr
    segmentgraph.add_node_attribute(node, (graph.node_attributes(node)[2][0], new_attr))


#print segmentgraph

filepath = r'%s_patterns.dot' % (benchmark)
outputfile  = open(filepath, 'w')
outputfile.write(dot.write(segmentgraph))
outputfile.close()

#command = 'dot -Tpng %s_patterns.dot > %s_patterns.png' % (benchmark, benchmark)
#os.system(command)

'''
print "----------------------------------------"
print "--creation of segment graph with edges--"
print "----------------------------------------"
'''

fullsegmentgraph = dot.read(data);
#print fullsegmentgraph


for node in fullsegmentgraph:
    for new_node in segmentgraph:
        if node == new_node:
            #print segmentgraph.node_attributes(new_node)[0]
            fullsegmentgraph.add_node_attribute(node, segmentgraph.node_attributes(new_node)[0])
            #fullsegmentgraph.set_next_node(node, segmentgraph.check_next_node(node))


'''
print fullsegmentgraph


print "-------------------------------------------------"
print "--replacing three node segment with single node--"
print "-------------------------------------------------"
'''

if(flag_three_node):
    for eachsegment in threenode_segmentlist:
        #print eachsegment
        node = eachsegment[0]
        #print fullsegmentgraph.node_attributes(node)[0]
        label_node = fullsegmentgraph.node_attributes(node)[2][1]
        child =  fullsegmentgraph.neighbors(node)
        childofchild =  fullsegmentgraph.neighbors(child[0])
        label_child = fullsegmentgraph.node_attributes(child[0])[2][1]
        label_childofchild = fullsegmentgraph.node_attributes(childofchild[0])[2][1]
        #print child[0], label_child, childofchild[0], label_childofchild
        incident_child_nodes = fullsegmentgraph.incidents(child[0])
        incident_childofchild_nodes = fullsegmentgraph.incidents(childofchild[0])
        neighbor_nodes = fullsegmentgraph.neighbors(childofchild[0])
        #print incident_child_nodes, incident_childofchild_nodes, neighbor_nodes
        for neighbor in neighbor_nodes:
            fullsegmentgraph.add_edge((node,neighbor), 1, "", [])
            #print "connecting", node, "and", neighbor

        for incident in incident_child_nodes:
            if len(incident_child_nodes) > 1 and incident != node:
                if fullsegmentgraph.has_edge((incident,node))==False:
                    #print fullsegmentgraph.has_edge((incident,node))
                    fullsegmentgraph.add_edge((incident,node), 1, "", [])
                    #print "connecting", incident, "and", node

        for incident in incident_childofchild_nodes:
            if len(incident_childofchild_nodes) > 1 and incident != child[0]:
                if fullsegmentgraph.has_edge((incident,node))==False:
                    #print fullsegmentgraph.has_edge((incident,node))
                    fullsegmentgraph.add_edge((incident,node), 1, "", [])
                    #print "connecting", incident, "and", node

        fullsegmentgraph.del_node(childofchild[0]);
        fullsegmentgraph.del_node(child[0]);

'''

print "-------------------------------------------------"
print "--replacing two node segment with single node--"
print "-------------------------------------------------"
'''

for eachsegment in twonode_segmentlist:
    #print eachsegment
    node = eachsegment[0]
    #print node
    #print fullsegmentgraph.node_attributes(node)
    label_node = fullsegmentgraph.node_attributes(node)[2][1]
    child =  fullsegmentgraph.neighbors(node)
    label_child = fullsegmentgraph.node_attributes(child[0])[2][1]
    #print child[0], label_child
    incident_child_nodes = fullsegmentgraph.incidents(child[0])
    neighbor_nodes = fullsegmentgraph.neighbors(child[0])
    #print incident_child_nodes, neighbor_nodes
    for neighbor in neighbor_nodes:
        fullsegmentgraph.add_edge((node,neighbor), 1, "", [])
        #print "connecting", node, "and", neighbor

    for incident in incident_child_nodes:
        if len(incident_child_nodes) > 1 and incident != node:
            if fullsegmentgraph.has_edge((incident,node))==False:
                #print fullsegmentgraph.has_edge((incident,node))
                fullsegmentgraph.add_edge((incident,node), 1, "", [])
                #print "connecting", incident, "and", node

    fullsegmentgraph.del_node(child[0]);

'''
filepath = r'%s_fullsegmentgraph.dot' % (benchmark)
outputfile  = open(filepath, 'w')
outputfile.write(dot.write(fullsegmentgraph))
outputfile.close()

command = 'dot -Tpng %s_fullsegmentgraph.dot > %s_fullsegmentgraph.png' % (benchmark, benchmark)
os.system(command)
'''


graph = digraph()
graph = fullsegmentgraph
#print graph

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
		new_digraph.add_node_attribute(nodename, ("ntype", '"invar"'));
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
		new_digraph.add_node_attribute(nodename, ("ntype", '"invar"'));
                node_num = node_num + 1;
                input_num = input_num + 1;

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
		new_digraph.add_node_attribute(nodename, ("ntype", '"operation"'));
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
		new_digraph.add_node_attribute(nodename, ("ntype", '"outvar"'));
                node_num = node_num + 1;
                output_num = output_num + 1;

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
		new_digraph.add_node_attribute(nodename, ("ntype", '"outvar"'));
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
'''
print "-------fanin and fanout in DSP graph-------------"
for each in new_digraph:
        print each, len(new_digraph.incidents(each)), len(new_digraph.neighbors(each))
'''

filepath = r'%s.dot' % (benchmark)
outputfile  = open(filepath, 'w')
outputfile.write(dot.write(new_digraph))
outputfile.close()
#command = 'dot -Tpng %s.dot > %s.png' % (benchname, benchname)
#os.system(command)


dsp_nodes = len(new_digraph.nodes()) - (input_num+output_num);

#print "-------------------------------------------------"
#print "-------DSP merging in FU starts here-------------"
#print "-------------------------------------------------"
fu_graph = digraph()
fu_graph = new_digraph

for each in fu_graph:
    fu_graph.set_level(each, 0)

for each in new_digraph:
    if(each in fu_graph):
        if((len(fu_graph.neighbors(each)) == 1) & (len(fu_graph.incidents(each)) != 0)):
            child = fu_graph.neighbors(each)
            child_incident = fu_graph.incidents(child[0])
            each_incident = fu_graph.incidents(each);
            #print each_incident
            #print child_incident
            #print each_incident + child_incident
            fan_in_nodes = list(set(each_incident + child_incident))
            fan_in_nodes.remove(each)
            #print fan_in_nodes
            fan_in = len(fan_in_nodes)
            #print fan_in
            if((fu_graph.check_level(child[0]) != 1) & (fan_in <= 4)):
                childofchild = fu_graph.neighbors(child[0])
                #print each, child, childofchild, child_incident
                if(childofchild != []):
                    for each_childofchild in childofchild:
                        if fu_graph.has_edge((each,each_childofchild))==False:
                            fu_graph.add_edge((each,each_childofchild), 1, "", [])
                            #print "connecting", each, "and", each_childofchild
                for incident in child_incident:
                    if len(child_incident) > 1 and incident != each:
                        if fu_graph.has_edge((incident, each))==False:
                            fu_graph.add_edge((incident,each), 1, "", [])
                            #print "connecting", incident, "and", each
                if(childofchild != []):
                    #print "deleting", child[0]
                    fu_graph.del_node(child[0]);
                    fu_graph.set_level(each, 1);


node_num = dsp_nodes + input_num + output_num;
dummynode_num = 0;
for each in fu_graph:
	if(len(fu_graph.neighbors(each))>1):
		dummynode_num = dummynode_num + len(fu_graph.neighbors(each));
'''
for each in fu_graph:
    #print fu_graph.node_attributes(each)[0], fu_graph.node_attributes(each)[1], fu_graph.node_attributes(each)[2]
    ntype = fu_graph.node_attributes(each)[2][1];
    if(ntype == '"invar"'):
        for each_child in fu_graph.neighbors(each):
            node_num = node_num + 1;
            nodename = r'N%s' % (node_num);
            fu_graph.add_node(nodename);
            fu_graph.add_node_attribute(nodename, ("color", '"black"'));
            fu_graph.add_node_attribute(nodename, ("ntype", '"invar"'));
            if fu_graph.has_edge((nodename, each_child))==False:
                fu_graph.add_edge((nodename,each_child), 1, "", [])

        fu_graph.del_node(each)

'''

'''
print "-------fanin and fanout in FU graph-------------"
for each in fu_graph:
        print each, len(fu_graph.incidents(each)), len(fu_graph.neighbors(each))
'''

filepath = r'%s_fu.dot' % (benchmark)
outputfile  = open(filepath, 'w')
outputfile.write(dot.write(fu_graph))
outputfile.close()
command = 'dot -Tpng %s_fu.dot > %s_fu.png' % (benchmark, benchmark)
os.system(command)

#print new_digraph
#print fu_graph

[new_input_num, new_output_num] = GenerateNetlist(fu_graph, benchmark);
op_nodes = len(my_graph.nodes()) - (input_num+output_num);
fu_nodes = len(fu_graph.nodes()) - (new_input_num+new_output_num);
print "---------------------------------------"
#print "Graph nodes:            ", my_graph.nodes();
#print "Mapped-Graph nodes:        ", new_digraph.nodes();
print "Total nodes:                    ", len(my_graph.nodes());
print "I/O nodes:                      ", input_num, "/", output_num;
print "OP nodes:                       ", op_nodes;
print "DSP nodes:                      ", dsp_nodes;
print "FU nodes:                       ", fu_nodes;
print "% FU Savings w/o DSP merging:   ", 100*(op_nodes - dsp_nodes)/op_nodes, "%";
print "% FU Savings w DSP merging:     ", 100*(op_nodes - fu_nodes)/op_nodes, "%";
print "New I/O nodes:                  ", new_input_num, "/", new_output_num;
print "Dummy nodes:        	       ", dummynode_num;







'''

[input_num, output_num] = GenerateNetlist(new_digraph, benchmark);
op_nodes = len(my_graph.nodes()) - (input_num+output_num);
op_nodes_tech_mapped = len(new_digraph.nodes()) - (input_num+output_num);
print "---------------------------------------"
#print "Graph nodes:            ", my_graph.nodes();
#print "Mapped-Graph nodes:        ", new_digraph.nodes();
print "Total nodes:                   ", len(my_graph.nodes());
print "I/O nodes:                     ", input_num, "/", output_num;
print "OP nodes:                      ", op_nodes;
print "OP nodes after tech-mapping:   ", op_nodes_tech_mapped;
print "% Savings:                     ", 100*(op_nodes - op_nodes_tech_mapped)/op_nodes, "%";
#rint "---------------------------------------"
#GenerateNetlist(new_digraph, benchmark);

'''








'''


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
templates = ['muad', 'musu', 'admu', 'sumu', 'adad', 'adsu', 'suad', 'susu', 'sqad', 'sqsu']


new_graph = digraph();

for level in sequencing_graph[0:len(sequencing_graph)-1]:
#    print level
    for node in level:
#        print 'current node-', node
        successors = graph.neighbors(node)
        #for successor in successors:
        if(len(successors)==1):
            successor = successors[0]
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


print "here is the new graph"
print new_graph
list_of_newnodes = new_graph.nodes();
print list_of_newnodes
#print 'list'
#print new_graph
filepath = r'%s_patterns.dot' % (benchmark)
outputfile  = open(filepath, 'w')
outputfile.write(dot.write(new_graph))
outputfile.close()

command = 'dot -Tpng %s_patterns.dot > %s_patterns.png' % (benchmark, benchmark)
os.system(command)


#print list_of_newnodes

for node in new_graph:
    list_of_newnodes.append(new_graph.check_next_node(node))

print list_of_newnodes

for node in graph:
    for new_node in new_graph:
        if node == new_node:
#            print new_graph.node_attributes(new_node)[0]
            #print graph.node_attributes(new_node)[0]
            graph.add_node_attribute(node, new_graph.node_attributes(new_node)[0])
            #print graph.node_attributes(new_node)[0]
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

print graph

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

benchname = 'sgfilter';
filepath = r'%s.dot' % (benchname)
outputfile  = open(filepath, 'w')
outputfile.write(dot.write(new_digraph))
outputfile.close()
command = 'dot -Tpng %s.dot > %s.png' % (benchname, benchname)
os.system(command)


[input_num, output_num] = GenerateNetlist(new_digraph, benchmark);
op_nodes = len(my_graph.nodes()) - (input_num+output_num);
op_nodes_tech_mapped = len(new_digraph.nodes()) - (input_num+output_num);
print "---------------------------------------"
#print "Graph nodes:            ", my_graph.nodes();
#print "Mapped-Graph nodes:        ", new_digraph.nodes();
print "Total nodes:               ", len(my_graph.nodes());
print "I/O nodes:                      ", input_num, "/", output_num;
print "OP nodes:            ", op_nodes;
print "OP nodes after tech-mapping:    ", op_nodes_tech_mapped;
print "% Savings:            ", 100*(op_nodes - op_nodes_tech_mapped)/op_nodes, "%";
#rint "---------------------------------------"
#GenerateNetlist(new_digraph, benchmark);


'''


