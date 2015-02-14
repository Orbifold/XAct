//
//  Graph.swift
//  XAct
//
//  Created by Francois Vanderseypen on 2/14/15.
//  Copyright (c) 2015 Orbifold. All rights reserved.
//

import Foundation

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
    init(){
        self.Uid = NSUUID().UUIDString
        self.isDirected = true
        self.Edges = [Edge<TNodeData, TEdgeData>]()
        self.Nodes = [Node<TNodeData, TEdgeData>]()
    }
    
    public func Add(item:IGraphElement) -> IGraphElement?{
        if item is Node<TNodeData, TEdgeData>{
            let node = item as Node<TNodeData, TEdgeData>
            if(node.Id != nil && IdExists(node.Id!)){
                NSException(name:"Graph error", reason:"A node with the same id already is part of the graph.", userInfo:nil).raise()
            }
            node.IsDirected = self.isDirected
            Nodes.append(node)
            return node
        }
        else if item is Edge<TNodeData, TEdgeData>{
            let edge = item as Edge<TNodeData, TEdgeData>
            edge.IsDirected = self.isDirected
            return AddEdge(edge)
        }
        return nil
    }
    public func AddEdge(from:Int, to:Int) -> Edge<TNodeData, TEdgeData>?{
        if( IdExists(from) && IdExists(to) ){
            var edge = Edge<TNodeData, TEdgeData>()
            edge.Source = FindNode(from)!
            edge.Sink = FindNode(to)!
            Edges.append(edge)
            return edge
        }
        return nil
    }
    
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
            if(anyDirection){
                if(edge.Sink == fromNode && edge.Source == toNode) {
                    return true
                }
            }
        }
        return false
    }
    
    func AddEdge(edge:Edge<TNodeData, TEdgeData>) -> Edge<TNodeData, TEdgeData>{
        self.Edges.append(edge);
        
        if (edge.Source != nil){
            edge.Source!.AddOutgoingEdge(edge);
            if find(Nodes, edge.Source!) != nil
            {
                self.Add(edge.Source!)
            }
        }
        if (edge.Sink != nil){
            edge.Sink!.AddIncomingEdge(edge);
            if find(Nodes, edge.Sink!) != nil
            {
                self.Add(edge.Sink!)
            }
        }
        
        return edge;
    }
    
    public var IsConnected:Bool{get{ return self.GetConnectedComponents().count == 1}}
    
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
    func IdExists(id:Int) -> Bool{
        return FindNode(id) != nil
    }
    public func FindNode(id:Int) -> Node<TNodeData, TEdgeData>?
    {
        for node in Nodes{
            
            if(node.Id != nil  && node.Id == id){
                return node
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
            if(node.Id == nil) {
                NSException(name:"Unique identifier error", reason:"All nodes in the graph have to have a unique id.", userInfo:nil).raise()
            }
            if let index = find(ids, node.Id!) {
                NSException(name:"Unique identifier error", reason:"Node with id \(node.Id!) is not unique.", userInfo:nil).raise()
            }
            ids.append(node.Id!)
        }
    }
    
    public func NumberOfComponents() -> (Int, [Int:Int])
    {
        var componentIndex = 0
        var componentMap = [Int:Int]()
        for t in Nodes{
            componentMap[t.Id!] = -1
        }
        for( var k = 0; k<Nodes.count; k++){
            
            if(componentMap[Nodes[k].Id!] != -1){ continue} // means it already belongs to a component
            self.AssignConnectedConponent(componentMap, listIndex: k, componentIndex: componentIndex)
            componentIndex++
        }
        return (componentIndex, componentMap)
    }
    
    func AssignConnectedConponent(var componentMap:[Int:Int], listIndex: Int, componentIndex:Int){
        var node = Nodes[listIndex]
        componentMap[node.Id!] = componentIndex
        var neighbors = node.Neighbors
        for neighbor in neighbors{
            if (componentMap[neighbor.Id!] == -1) {
                
                let unvisitedIndex = find(Nodes, neighbor)
                self.AssignConnectedConponent(componentMap,listIndex: unvisitedIndex!, componentIndex: componentIndex)
            }
        }
    }
}

public func ==<TNodeData, TEdgeData>(lhs: Graph<TNodeData, TEdgeData>, rhs: Graph<TNodeData, TEdgeData>) -> Bool{
    return lhs.Uid == rhs.Uid
}