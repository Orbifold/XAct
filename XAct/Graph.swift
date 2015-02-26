//
//  Graph.swift
//  XAct
//
//  Created by Francois Vanderseypen on 2/14/15.
//  Copyright (c) 2015 Orbifold. All rights reserved.
//

import Foundation

public typealias ObjectGraph = Graph<AnyObject, AnyObject>
public typealias ObjectNode = Node<AnyObject, AnyObject>
public typealias ObjectEdge = Edge<AnyObject, AnyObject>

public protocol IGraphElement{
    
}

/**
The graph data structure.
*/
public class Graph<TNodeData, TEdgeData>: Equatable
{
    private var Uid:String;
    private var isDirected:Bool
    public var Nodes:[Node<TNodeData, TEdgeData>]
    public var Edges:[Edge<TNodeData, TEdgeData>]
    public var Root:Node<TNodeData, TEdgeData>?
    public var IsDirected:Bool{get{return self.isDirected}}
    
    init(isDirected:Bool = true){
        self.Uid = NSUUID().UUIDString
        self.isDirected = isDirected
        self.Root = nil
        self.Edges = [Edge<TNodeData, TEdgeData>]()
        self.Nodes = [Node<TNodeData, TEdgeData>]()
    }
    
    /**
    Returns true if the graph has no loops.
    */
    public var IsSimple:Bool{get{
        for edge in Edges{
            if(edge.Source == edge.Sink){ return false}
        }
        return true
        }}
    
    /**
    Adds the given graph item to this graph.
    */
    public func Add(item:IGraphElement) -> IGraphElement?{
        if item is Node<TNodeData, TEdgeData>{
            let node = item as Node<TNodeData, TEdgeData>
            return self.AddNode(node)
        }
        else if item is Edge<TNodeData, TEdgeData>{
            let edge = item as Edge<TNodeData, TEdgeData>
            
            return AddEdge(edge)
        }
        return nil
    }
    
    /**
    Adds the given node to the graph.
    */
    public func AddNode(node:Node<TNodeData, TEdgeData>) -> Node<TNodeData, TEdgeData>{
        var found = FindNode(node.Id)
        if(found != nil){
            NSException(name:"Graph error", reason:"A node with this id already exists.", userInfo:nil).raise()
        }
        if(node.Outgoing.count>0 || node.Incoming.count>0){
            // would initiate a potential cascade of node additions
            NSException(name:"Graph error", reason:"The given node has incoming and/or outgoing edges, please use merge to merge graphs or remove the edges from the node.", userInfo:nil).raise()
            return node
        }
        self.Nodes.append(node)
        return node
    }
    
    /**
    Adds or returns the node with the given identifier.
    */
    public func AddNode(id:Int) -> Node<TNodeData,TEdgeData>{
        var found = FindNode(id)
        if(found != nil){return found!}
        found = Node<TNodeData,TEdgeData>(id: id)
        self.Nodes.append(found!)
        return found!;
    }
    
    /**
    Adds an edge to the graph between the given indices.
    */
    public func AddEdge(from:Int, to:Int) -> Edge<TNodeData, TEdgeData>{
        var found = FindEdge(from, to: to)
        if(found != nil){
            return found!
        }
        var source = IdExists(from) ? FindNode(from)! : self.AddNode(from);
        var sink = IdExists(to) ? FindNode(to)! : self.AddNode(to);
        var edge = Edge<TNodeData, TEdgeData>(source: source, sink: sink)
        Edges.append(edge)
        return edge
    }
    
    /**
    Adds an edge to the graph between the given nodes.
    */
    public func AddEdge(source:Node<TNodeData,TEdgeData>, sink:Node<TNodeData,TEdgeData>) -> Edge<TNodeData,TEdgeData>{
        return AddEdge(source.Id,to: sink.Id)
    }
    
    /**
    Returns whether the given indices are connected in this graph.
    */
    public func AreConnected(from:Int, to:Int, anyDirection:Bool = false) -> Bool{
        let fromNode = FindNode(from)
        let toNode = FindNode(to)
        if(fromNode == nil || toNode == nil){
            return false
        }
        for edge in Edges{
            if(edge.Source == fromNode && edge.Sink == toNode) {
                return true
            }
            if(anyDirection || !IsDirected){
                if(edge.Sink == fromNode && edge.Source == toNode) {
                    return true
                }
            }
        }
        return false
    }
    
    public func AreConnected(from:Node<TNodeData,TEdgeData>, to:Node<TNodeData,TEdgeData>, anyDirection:Bool = false) -> Bool{
        return AreConnected(from.Id, to: to.Id, anyDirection: anyDirection)
    }
    
    /**
    Connects the given node id's.
    */
    public func Connect(from:Int, to:Int) -> Edge<TNodeData, TEdgeData>{
        return self.AddEdge(from, to: to)
    }
    
    /**
    Adds the given edge to this graph.
    */
    func AddEdge(edge:Edge<TNodeData, TEdgeData>) -> Edge<TNodeData, TEdgeData>{
        
        if let index = find(Edges,edge) {
            NSException(name:"Graph error", reason:"The edge is already part of the graph.", userInfo:nil).raise()
            return edge
        }
        if(self.AreConnected(edge.Source.Id, to: edge.Sink.Id, anyDirection: self.isDirected)){
            NSException(name:"Graph error", reason:"The given edge already is part of the graph.", userInfo:nil).raise()
            return edge
        }
        
        edge.IsDirected = self.isDirected
        
        self.Edges.append(edge);
        
        
        edge.Source.AddOutgoingEdge(edge);
        if find(Nodes, edge.Source) != nil
        {
            self.Add(edge.Source)
        }
        
        edge.Sink.AddIncomingEdge(edge);
        if find(Nodes, edge.Sink) != nil
        {
            self.Add(edge.Sink)
        }
        
        return edge;
    }
    
    /**
    Removes the given edge from this graph.
    */
    public func RemoveEdge(edge:Edge<TNodeData,TEdgeData>) -> Bool{
        if let index = find(self.Edges, edge){
            self.Edges.removeAtIndex(index)
            return true
        }
        return false
    }
    
    /**
    Returns whether this graph is connected.
    */
    public var IsConnected:Bool{get{ return self.GetConnectedComponents().count == 1}}
    
    /**
    Returns the connected components of this graph.
    */
    public func GetConnectedComponents() ->[ Graph<TNodeData, TEdgeData>]{
        self.EnsureUniqueIdentifiers()
        var (componentsCount, componentMap) = self.NumberOfComponents()
        
        var components = [Graph<TNodeData, TEdgeData>]()
        for(var k = 0; k<componentsCount; k++){
            components.append(Graph<TNodeData, TEdgeData>())
        }
        for nodeId in componentMap.keys{
            var graph = components[componentMap[nodeId]!]
            var node = self.FindNode(nodeId)
            graph.Nodes.append(node!);
            for edge in node!.Outgoing{
                graph.Edges.append(edge)
            }
        }
        return components
    }
    
    /**
    Returns whether the given id exists in this graph.
    */
    func IdExists(id:Int) -> Bool{
        return FindNode(id) != nil
    }
    
    /**
    Returns the node with the given identifier.
    */
    public func FindNode(id:Int) -> Node<TNodeData, TEdgeData>?
    {
        for node in Nodes{
            
            if( node.Id == id){
                return node
            }
        }
        return nil
    }
    
    public func FindEdge(from:Int, to:Int) -> Edge<TNodeData, TEdgeData>?{
        for edge in Edges{
            
            if(edge.Source.Id == from  && edge.Sink.Id == to){
                return edge
            }
            if(!self.isDirected && (edge.Sink.Id == from  && edge.Source.Id == to)){
                return edge
            }
        }
        return nil
        
    }
    /**
    Ensures that all nodes in the graph have a unique id.
    */
    public func EnsureUniqueIdentifiers()
    {
        var ids = [Int]();
        for node in self.Nodes
        {
            
            if let index = find(ids, node.Id) {
                NSException(name:"Unique identifier error", reason:"Node with id \(node.Id) is not unique.", userInfo:nil).raise()
            }
            ids.append(node.Id)
        }
    }
    /**
    Returns the number of components and the map from a node id to the id of the component the node belongs to.
    */
    public func NumberOfComponents() -> (Int, [Int:Int])
    {
        var componentIndex = 0
        var componentMap = [Int:Int]()
        for t in Nodes{
            componentMap[t.Id] = -1
        }
        for( var k = 0; k<Nodes.count; k++){
            
            if(componentMap[Nodes[k].Id] != -1){ continue} // means it already belongs to a component
            self.AssignConnectedConponent(componentMap, listIndex: k, componentIndex: componentIndex)
            componentIndex++
        }
        return (componentIndex, componentMap)
    }
    /**
    Utility metbod related to the connectedness of this graph.
    */
    func AssignConnectedConponent(var componentMap:[Int:Int], listIndex: Int, componentIndex:Int){
        var node = Nodes[listIndex]
        componentMap[node.Id] = componentIndex
        var neighbors = node.Neighbors
        for neighbor in neighbors{
            if (componentMap[neighbor.Id] == -1) {
                
                let unvisitedIndex = find(Nodes, neighbor)
                self.AssignConnectedConponent(componentMap,listIndex: unvisitedIndex!, componentIndex: componentIndex)
            }
        }
    }
    
    /**
    * Returns a random node in this graph.
    * @param excludedNodes The collection of nodes which should not be considered.
    * @param incidenceLessThan The maximum degree or incidence the random node should have.
    * @returns {*}
    */
    public func TakeRandomNode (excludedNodes:[Int] = [], incidenceLessThan:Int = 1000) -> Node<TNodeData,TEdgeData>?{
        
        if (self.Nodes.count == 0) {
            return nil;
        }
        if (self.Nodes.count == 1) {
            return (find(excludedNodes, self.Nodes[0].Id) != nil) ? nil : self.Nodes[0];
        }
        var pool = filter(self.Nodes, {find(excludedNodes, $0.Id) == nil && $0.Degree <= incidenceLessThan})
        
        if (pool.count == 0) {
            return nil;
        }
        return pool[Math.Random(0, max: pool.count)];
    }
    /**
    * Creates a random graph (uniform distribution) with the specified amount of nodes.
    * @param nodeCount The amount of nodes the random graph should have.
    * @param maxIncidence The maximum allowed degree of the nodes.
    * @param isTree Whether the return graph should be a tree (default: false).
    * @returns {diagram.Graph}
    */
    public class func RandomConnectedGraph(nodeCount:Int = 40, maxIncidence:Int = 4, isTree:Bool = false) -> ObjectGraph
    {
        
        /* Mathematica export of random Bernoulli graphs
        gr[n_,p_]:=Module[{g=RandomGraph[BernoulliGraphDistribution[n,p],VertexLabels->"Name",DirectedEdges->True]},
        While[Not[ConnectedGraphQ[g]],g=RandomGraph[BernoulliGraphDistribution[n,p],VertexLabels->"Name",DirectedEdges->True]];g];
        project[a_]:=("\""<>ToString[Part[#,1]]<>"->"<>ToString[Part[#,2]]<>"\"")&     @ a;
        export[g_]:=project/@ EdgeList[g]
        g = gr[12,.1]
        export [g]
        */
        
        var g =  ObjectGraph()
        var counter:Int = -1;
        if (nodeCount <= 0) {
            return g;
        }
        counter++
        var root =  ObjectNode(id: counter);
        g.AddNode(root);
        if (nodeCount == 1) {
            return g;
        }
        
        // random tree
        for (var i = 1; i < nodeCount; i++) {
            var poolNode = g.TakeRandomNode(excludedNodes: [], incidenceLessThan: maxIncidence);
            if (poolNode == nil) {
                //failed to find one so the graph will have less nodes than specified
                break;
            }
            var newNode = g.AddNode(i);
            g.AddEdge(poolNode!, sink: newNode);
        }
        if (!isTree && nodeCount > 1) {
            var randomAdditions = Math.Random(1, max: nodeCount);
            for (var ri = 0; ri < randomAdditions; ri++) {
                var n1 = g.TakeRandomNode(excludedNodes: [], incidenceLessThan: maxIncidence);
                var n2 = g.TakeRandomNode(excludedNodes: [], incidenceLessThan: maxIncidence);
                if ((n1 != nil) && (n2 != nil) && !g.AreConnected(n1!, to: n2!)) {
                    g.AddEdge(n1!, sink: n2!);
                }
            }
        }
        return g;
        
        
    }
    
    public class func  CreateBalancedForest(levels:Int = 3, siblingsCount:Int = 3, treeCount:Int = 5) -> ObjectGraph{
        var g =  ObjectGraph()
        var counter = -1
        var lastAdded:[ObjectNode] = []
        var news:[ObjectNode]
        if (levels <= 0 || siblingsCount <= 0 || treeCount <= 0) {
            return g
        }
        
        for (var t = 0; t < treeCount; t++) {
            counter++
            var root =   ObjectNode(id: counter );
            g.AddNode(root);
            lastAdded = [root];
            for (var i = 0; i < levels; i++) {
                news = [];
                for (var j = 0; j < lastAdded.count; j++) {
                    var parent = lastAdded[j];
                    for (var k = 0; k < siblingsCount; k++) {
                        counter++
                        var item =   ObjectNode(id: counter);
                        g.AddEdge(parent, sink: item);
                        news.append(item);
                    }
                }
                lastAdded = news;
            }
        }
        return g;
    }
    
    public class func CreateBalancedTree (levels:Int = 3, siblingsCount:Int = 3) -> ObjectGraph{
        
        var g = ObjectGraph()
        var counter = -1
        var lastAdded:[ObjectNode] = []
        var news:[ObjectNode]
        if (levels <= 0 || siblingsCount <= 0) {
            return g
        }
        counter++
        var root =  ObjectNode(id: counter);
        g.AddNode(root);
        g.Root = root;
        lastAdded.append(root);
        for (var i = 0; i < levels; i++) {
            news = [];
            for (var j = 0; j < lastAdded.count; j++) {
                var parent = lastAdded[j];
                for (var k = 0; k < siblingsCount; k++) {
                    counter++
                    var item = ObjectNode(id: counter);
                    g.AddEdge(parent, sink: item);
                    news.append(item);
                }
            }
            lastAdded = news;
        }
        return g;
    }
    /**
    Parses the given string graph representation and returns the corresponding ObjectGraph.
    For example, "1->2, 2->3, 3->1"
    */
    public class func Parse(var graphString:String) -> ObjectGraph{
        var g = ObjectGraph()
        if(graphString.isEmpty){return g}
       
        // if -> appears once we'll assume a directed graph
        g.isDirected = graphString.rangeOfString("->") != nil
        var separator = g.IsDirected ?"->" :"-"
        // handle the mixed case
        graphString = graphString.stringByReplacingOccurrencesOfString("->", withString: "-")
        if(g.IsDirected){
            graphString = graphString.stringByReplacingOccurrencesOfString("-", withString: "->")
        }
        var splitted = graphString.componentsSeparatedByString(",")
        for edgeString in splitted {
            var el = edgeString.componentsSeparatedByString(separator)
            var fromId = el[0].toInt()
            var toId = el[1].toInt()
            if(fromId != nil && toId != nil){
                g.AddEdge(fromId!, to: toId!)
            }
        }
        return g
    }
}

public func ==<TNodeData, TEdgeData>(lhs: Graph<TNodeData, TEdgeData>, rhs: Graph<TNodeData, TEdgeData>) -> Bool{
    return lhs.Uid == rhs.Uid
}