//
//  MathTests.swift
//  XAct
//
//  Created by Francois Vanderseypen on 2/11/15.
//  Copyright (c) 2015 Orbifold. All rights reserved.
//

import Foundation
import XCTest

class MathTests : XCTestCase{
    
    func testRandom(){
        for _ in 1...50{
            var x = Math.Random()
            XCTAssertTrue(x > 0 && x < 1, "Number \(x) is not really random.")
        }
        
        for _ in 1...50{
            var x = Math.Random(1,max: 100)
            XCTAssertTrue(x >= 1  && x < 100, "Number \(x) is not really random within the (1, 100) interval.")
        }
    }
}