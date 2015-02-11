//
//  NumberTests.swift
//  XAct
//
//  Created by Francois Vanderseypen on 2/11/15.
//  Copyright (c) 2015 Orbifold. All rights reserved.
//

import Foundation
import XCTest

class NumberTests: XCTestCase{
    
    func testIsEven(){
        XCTAssertTrue(Numbers.IsEven(244),"244 is even I'd think.");
        XCTAssertTrue(!Numbers.IsEven(42901),"42901 isn't even.");
        XCTAssertTrue(!Numbers.IsEven(Int.max),"Max isn't even, it's undefined.");
    }
    
    func testIsOdd(){
        XCTAssertTrue(Numbers.IsOdd(-15301),"-15301 is odd.");
        XCTAssertTrue(!Numbers.IsOdd(40008),"40008 isn't even.");
        XCTAssertTrue(!Numbers.IsOdd(Int.max),"Max isn't even, it's undefined.");
    }
    
    func testIsPowerOfTwo(){
        XCTAssertFalse(Numbers.IsPowerOfTwo(-8),"-8 is not a power of two.");
        XCTAssertTrue(Numbers.IsPowerOfTwo(32),"32 is a power of two.");
        
    }
    
    func testTruncate(){
        XCTAssertEqual(Numbers.Truncate(2.3), 2.0,"Truncate(2.3) = 2")
        XCTAssertEqual(Numbers.Truncate(12.53), 12.0,"Truncate(12.53) = 13")
        XCTAssertEqual(Numbers.Truncate(-77.03), -77.0,"Truncate(-77.03) = -77")
    }
    func testCeilingToPowerOfTwo(){
        XCTAssertEqual(Numbers.CeilingToPowerOfTwo(Int32(3)), Int32(4))
        XCTAssertEqual(Numbers.CeilingToPowerOfTwo(Int32(20)), Int32(32))
        
    }
    
    func testGCD(){
        XCTAssertEqual(Numbers.GreatestCommonDivisor(144, 55708), 4);
        // an interesting bracket property of Fibonacci and GCD
        XCTAssertEqual(
            Numbers.GreatestCommonDivisor(
                Int(Functions.Fibonacci(13)),
                Int(Functions.Fibonacci(26))
            ),
            Int(Functions.Fibonacci(Numbers.GreatestCommonDivisor(13, 26)))
        );
    }
    
    func testLCM(){
        XCTAssertEqual(Numbers.LeastCommonMultiple(2,3,5), 30);
        XCTAssertEqual(Numbers.LeastCommonMultiple( -3, 4 - 2, 3, 16), 48);
        XCTAssertEqual(Numbers.LeastCommonMultiple( 122,33,7,195,323), 591681090);
    }
    
    func testAlmostEqual(){
        XCTAssertTrue(Numbers.AlmostEqual(2.334400000000000091, b: 2.3344, numberOfDigits: 5))
        XCTAssertTrue(Numbers.AlmostEqual(2.334, b: 2.334000000001, numberOfDigits: 3))
    }
}