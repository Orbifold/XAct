//
// Created by Francois Vanderseypen on 5/18/15.
// Copyright (c) 2015 Orbifold. All rights reserved.
//

import Foundation
import XCTest

class ComplexNumberTests: XCTestCase{
    
    func testCreate(){
        var z = 4 + 5.I;
        var w = 6 + 5.I;
        XCTAssertTrue(Im(z+w)==10 && Re(z+w)==10);
    }
    
    func testOperations(){
        var z = 4+6.I;
        XCTAssertTrue(Im(2*z) == 12 && Re(2*z) == 8);
        XCTAssertTrue(Im(z/2) == 3 && Re(z/2) == 2);
        XCTAssertTrue(Im(z + 7) == 6 && Re(z + 7) == 11);
        XCTAssertTrue(Im(z - 5) == 6 && Re(z - 5) == -1);
        XCTAssertTrue(Im(z * I) == 4 && Re(z * I) == -6);
        XCTAssertEqual(Math.Sqrt(52),Norm(z))
        XCTAssertTrue(Conjugate(z).Im == -6 && Conjugate(z).Re == 4)
    }
}