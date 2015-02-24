//
//  Edge.swift
//  XAct
//
//  Created by Francois Vanderseypen on 2/11/15.
//  Copyright (c) 2015 Orbifold. All rights reserved.
//

import Foundation


/**
The edge, connection or link of a graph.
*/
public class Edge<TNodeData, TEdgeData>: Equatable, IGraphElement
{
    /**
    Gets or sets the sink, end or target of this edge.
    */
    var Sink:Node<TNodeData, TEdgeData>;

    /**
    Gets or sets the source, origin or start of this edge.
    */
    var Source:Node<TNodeData, TEdgeData>;
    
    /**
    Gets or sets the weight of the edge.
    */
    var Weight:Double?
    
    private var Uid:String;
    /**
    Gets or sets whether this edge is part of a directed graph or
    whether the direction of this edge matters.
    */
    var IsDirected:Bool;
    /**
    Instantiates a new edge.
    */
    init(source:Node<TNodeData, TEdgeData>, sink:Node<TNodeData, TEdgeData>){
        self.Source = source;
        self.Sink = sink;
        self.Uid = NSUUID().UUIDString;
        self.IsDirected = true;

    }
    
    /**
    Returns the other endpoint of this edge, oppostie from the given one.
    */
    public func GetOppositeNode(node:Node<TNodeData, TEdgeData>) -> Node<TNodeData, TEdgeData>?
    {
        return node == self.Sink ? self.Source : self.Sink;
    }
}

public func ==<TNodeData, TEdgeData>(lhs: Edge<TNodeData, TEdgeData>, rhs: Edge<TNodeData, TEdgeData>) -> Bool{
    return lhs.Uid == rhs.Uid
}