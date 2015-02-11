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
public class Edge<TNodeData, TEdgeData>: Equatable
{
    /**
    Gets or sets the sink, end or target of this edge.
    */
    var Sink:Node<TNodeData, TEdgeData>?;

    /**
    Gets or sets the source, origin or start of this edge.
    */
    var Source:Node<TNodeData, TEdgeData>?;
    
    /**
    Gets or sets the weight of the edge.
    */
    var Weight:Double?
    
    private var Uid:String;
    
    /**
    Instantiates a new edge.
    */
    init(){
        self.Source = nil;
        self.Sink = nil;
        self.Uid = NSUUID().UUIDString;
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