//
//  DataStructureTests.swift
//  XAct
//
//  Created by Francois Vanderseypen on 2/11/15.
//  Copyright (c) 2015 Orbifold. All rights reserved.
//

import Foundation
import XCTest



class QueueTests : XCTestCase{
    
    func testQueueSimple(){
        var q = Queue<Int>();
        q.enQueue(34)
        q.enQueue(-2)
        q.enQueue(0)
        XCTAssertEqual(34,q.deQueue()!)
        XCTAssertEqual(-2,q.deQueue()!)
        XCTAssertEqual(0,q.deQueue()!)
    }
    
    func testQueueSequence(){
        var q = Queue<Character>()
        var s = "p-adic number theory";
        q.enQueue(SequenceOf<Character>(Array(s)))
        XCTAssertEqual(Character("p"), q.peek()!)
        XCTAssertEqual(s.length,q.count)
    }
    func testQueueGenerator(){
        
        var q = Queue<Int>();
        q.enQueue(SequenceOf<Int>(1...50))
        var c = 1
        for x in q{
            XCTAssertEqual(c, x)
            c++
        }
        var p = Queue<String>(array: ["a", "b", "c"]);
        var a = [String]()
        for s in p{
            a.append(s)
        }
        XCTAssertEqual(a, ["a", "b", "c"])
    }
}

class StackTests : XCTestCase{
    func testBasic(){
        var stack = Stack<Int>();
        stack.Push(32)
        stack.Push(-8)
        XCTAssertEqual(stack.Count,2)
        var top = stack.Pop()
        XCTAssertTrue(top != nil)
        XCTAssertEqual(top!, -8)
        XCTAssertEqual(stack.Count,1)
        top = stack.Pop()
        XCTAssertTrue(top != nil)
        XCTAssertEqual(top!, 32)
        XCTAssertEqual(stack.Count,0)
        top = stack.Pop()
        XCTAssertTrue(top == nil)
        XCTAssertEqual(stack.Count,0)
        
    }
}

class LinkedListTests: XCTestCase{
    func testBasic(){
        var ll = LinkedList<Int>()
        ll.AddLink(2)
        ll.AddLink(3)
        XCTAssertEqual(ll.count,2)
        XCTAssertTrue(ll.Head != nil)
        XCTAssertEqual(ll.Head.key, 2)
        XCTAssertEqual(ll.Head.next!.key, 3)
    }
}

class GraphTests: XCTestCase{
    
    func testParse(){
        // standard case
        var gString = "1->2,2->3,3->1"
        var g = ObjectGraph.Parse(gString)
        XCTAssertEqual(g.Nodes.count, 3, "Should have three nodes")
        XCTAssertEqual(g.Edges.count, 3, "Should have three edges")
        XCTAssertTrue(g.AreConnected(3,to: 1), "1 and 3 should be connected")
        XCTAssertTrue(g.IsSimple, "The graph is simple")
        
        // no multigraph
        gString = "1-2,1-2,2-1"
        g = ObjectGraph.Parse(gString)
        XCTAssertEqual(g.Nodes.count, 2, "Should have two nodes")
        XCTAssertEqual(g.Edges.count, 1, "Should have one edge")
        XCTAssertTrue(g.AreConnected(2,to: 1), "1 and 2 should be connected")
        XCTAssertTrue(g.IsSimple, "The graph is simple")
        
        // mixed case
        gString = "1-2,1->5,5->1"
        g = ObjectGraph.Parse(gString)
        XCTAssertEqual(g.Nodes.count, 3, "Should have three nodes")
        XCTAssertTrue(g.IsDirected, "The graph is directed")
        XCTAssertEqual(g.Edges.count, 3, "Should have three edges")
        
        // loops
        gString = "1-1,1-2,2-2"
        g = ObjectGraph.Parse(gString)
        XCTAssertEqual(g.Nodes.count, 2, "Should have two nodes")
        XCTAssertEqual(g.Edges.count, 3, "Should have three edges")
        XCTAssertTrue(g.AreConnected(2,to: 1), "1 and 2 should be connected")
        XCTAssertTrue(g.AreConnected(1,to: 1), "1 and 1 should be connected")
        XCTAssertTrue(!g.IsSimple, "The graph is not simple")
        
    }
    
    func testCreate(){
        var g = ObjectGraph()
        g.Add(ObjectNode(id: 1))
        g.Add(ObjectNode(id: 2))
        XCTAssertEqual(g.Nodes.count, 2)
        var edge = g.AddEdge(1,to: 2)
        XCTAssertEqual(g.Edges.count, 1)
        XCTAssertTrue(g.AreConnected(1,to: 2))
        g.RemoveEdge(edge)
        XCTAssertTrue(!g.AreConnected(1,to: 2,anyDirection: true))
    }
    
    func testNoMultiGraph(){
        var g = ObjectGraph()
        var edge = g.AddEdge(1,to: 2)
        edge.Weight = 102
        var other = g.Connect(1,to: 2)
        XCTAssertTrue(other.Weight != nil && other.Weight == 102)
    }
    
    func testUndirected(){
        var g = ObjectGraph(isDirected: false)
        var edge = g.Connect(1,to: 2)
        XCTAssertTrue(edge.IsDirected)
        var other = g.Connect(2,to: 1)
        XCTAssertEqual(edge,other)
    }
    
     func testComponents(){
        var gString = "1->2,2->3,3->1,4->5"
        var g = ObjectGraph.Parse(gString)
        XCTAssertEqual(g.Nodes.count, 5, "Should have five nodes")
        XCTAssertEqual(g.Edges.count, 4, "Should have four edges")

        var componentsCount = g.NumberOfComponents().count
        XCTAssertEqual(componentsCount,2)
    }
}
