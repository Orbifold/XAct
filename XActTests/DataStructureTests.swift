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
