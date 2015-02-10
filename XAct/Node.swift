//
//  Node.swift
//  XAct
//
//  Created by Francois Vanderseypen on 2/10/15.
//  Copyright (c) 2015 Orbifold. All rights reserved.
//

import Foundation

/**
The node or vertex of a graph.
*/
public class Node<TNodeData, TEdgeData>: Equatable
{
    
    private var incoming:[Edge<TNodeData, TEdgeData>]
    private var outgoing:[Edge<TNodeData, TEdgeData>]
    private var allEdges:[Edge<TNodeData, TEdgeData>]
    private var data:TNodeData?
    
    /**
    Gets or sets whether this node is part of a directed graph or
    whether all edges are both incoming and outgoing.
    */
    var IsDirected:Bool;
    
    /**
    The identifier of this node.
    */
    var Id:Int?;
    
    /**
    The globally unique identifier of this node.
    */
    private var Uid:String;
    /**
    Gets or sets whether this node is a root (of a tree e.g.).
    */
    var IsRoot:Bool;
    
    /**
    Default constructor
    */
    init( ){
        self.incoming = [Edge<TNodeData, TEdgeData>]()
        self.outgoing = [Edge<TNodeData, TEdgeData>]()
        self.allEdges = [Edge<TNodeData, TEdgeData>]()
        self.data = nil;
        self.IsRoot = false;
        self.IsDirected = true;
        self.Uid = NSUUID().UUIDString
    }
    
    /**
    Instantiates a new Node with the given identifier.
    
    :param: id The suposedly unique identifier of this node (across the graph).
    */
    convenience init(id:Int){
        self.init( );
        self.Id = id
    }
    
    /**
    Gets all edges (incoming and outgoing) connected to this nodes.
    */
    var AllEdges:[Edge<TNodeData, TEdgeData>] { get{return self.allEdges}}
    
    /**
    Gets the degree of this node.
    */
    var Degree:Int    {
        get
        {
            return self.allEdges.count;
        }
    }
    
    /**
    Gets or sets the incoming edges.
    */
    var Incoming:[Edge<TNodeData, TEdgeData>]{
        get
        {
            return self.IsDirected ? self.incoming : self.allEdges;
        }
        set
        {
            self.incoming = newValue;
        }
    }
    
    /**
    Gets or sets the outgoing edges.
    */
    var Outgoing:[Edge<TNodeData, TEdgeData>]{
        get
        {
            return self.IsDirected ? self.outgoing : self.allEdges;
        }
        set
        {
            self.outgoing = newValue;
        }
    }
    
    /**
    Gets the children nodes of this node. The children have an edge from this node to them.
    */
    var Children:[Node<TNodeData, TEdgeData>] {
        get
        {
            if(self.IsDirected)
            {
                var opps = [Node<TNodeData, TEdgeData>]()
                for edge in self.outgoing{
                    var n = edge.GetOppositeNode(self)
                    if(n==nil || n! == self){ continue} // loops
                    opps.append(n!)
                }
                return opps
            }
            else{
                return self.Neighbors;
            }
        }
    }
    
    /**
    Gets the parent nodes of this node. The parents have an edge from them to this node.
    */
    var Parents:[Node<TNodeData, TEdgeData>] {
        get
        {
            if(self.IsDirected)
            {
                var opps = [Node<TNodeData, TEdgeData>]()
                for edge in self.incoming{
                    var n = edge.GetOppositeNode(self)
                    if(n==nil || n! == self){ continue} // loops
                    opps.append(n!)
                }
                return opps
            }
            else{
                return self.Neighbors;
            }
        }
    }
    
    /**
    Gets the neighbor nodes of this node.
    */
    var Neighbors:[Node<TNodeData, TEdgeData>]{
        get
        {
            var neigs = [Node<TNodeData, TEdgeData>]()
            for edge in self.allEdges
            {
                var opps = edge.GetOppositeNode(self);
                if(opps==nil || opps! == self){ continue} // loops
                if(contains(neigs, opps!)){ neigs.append(opps!)}
            }
            return neigs;
        }
    }
    
    public func RemoveEdge(edge:Edge<TNodeData, TEdgeData>){
        self.RemoveIncomingEdge(edge);
        self.RemoveOutgoingEdge(edge);
    }
    
    public func RemoveIncomingEdge(edge:Edge<TNodeData, TEdgeData>){
        if (contains(self.incoming, edge))
        {
            if let index = find(self.incoming, edge) {
                self.incoming.removeAtIndex(index)
            }
            if let index = find(self.allEdges, edge) {
                self.allEdges.removeAtIndex(index)
            }
        }
    }
    
    public func RemoveOutgoingEdge(edge:Edge<TNodeData, TEdgeData>){
        if (contains(self.outgoing, edge))
        {
            if let index = find(self.outgoing, edge) {
                self.incoming.removeAtIndex(index)
            }
            if let index = find(self.allEdges, edge) {
                self.allEdges.removeAtIndex(index)
            }        }
    }
     
}

public func ==<TNodeData, TEdgeData>(lhs: Node<TNodeData, TEdgeData>, rhs: Node<TNodeData, TEdgeData>) -> Bool{
    return lhs.Id == rhs.Id
}

/**
The edge, connection or link of a graph.
*/
public class Edge<TNodeData, TEdgeData>: Equatable
{
    var Sink:Node<TNodeData, TEdgeData>?;
    var Source:Node<TNodeData, TEdgeData>?;
    private var Uid:String;
    init(){
        self.Source = nil;
        self.Sink = nil;
        self.Uid = NSUUID().UUIDString;
    }
    
    public func GetOppositeNode(node:Node<TNodeData, TEdgeData>) -> Node<TNodeData, TEdgeData>?
    {
        return node == self.Sink ? self.Source : self.Sink;
    }
}

public func ==<TNodeData, TEdgeData>(lhs: Edge<TNodeData, TEdgeData>, rhs: Edge<TNodeData, TEdgeData>) -> Bool{
    return lhs.Uid == rhs.Uid
}