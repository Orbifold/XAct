//
//  FunctionsTests.swift
//  XAct
//
//  Created by Francois Vanderseypen on 2/11/15.
//  Copyright (c) 2015 Orbifold. All rights reserved.
//

import Foundation
import UIKit
import XCTest





class FunctionTests : XCTestCase
{
    let Accuracy = 1e-6
    
    func testBetaRegularized()
    {
        XCTAssertEqualWithAccuracy(0.651473, Functions.BetaRegularized(0.1, b: 0.22, x: 0.33), Accuracy);
        XCTAssertEqualWithAccuracy(0.470091, Functions.BetaRegularized(0.55, b: 0.77, x: 0.33), Accuracy);
    }
    
    func testGammas(){
        XCTAssertEqualWithAccuracy(1.50856818610322, Functions.GammaLn(3.76835145950317), Accuracy)
        XCTAssertEqualWithAccuracy(1.52395510070524, Functions.GammaLn(3.78128070831299), Accuracy);
        XCTAssertEqualWithAccuracy(3.51639004045872, Functions.GammaLn(5.22110624313355), Accuracy);
        XCTAssertEqualWithAccuracy(1.05593856001418, Functions.GammaLn(3.36578979492187), Accuracy);
        XCTAssertEqualWithAccuracy(2.93885210191772, Functions.GammaLn(4.83925867080688), Accuracy);
        XCTAssertEqualWithAccuracy(0.513590205904634, Functions.GammaLn(2.79629344940186), Accuracy);
        XCTAssertEqualWithAccuracy(0.429146817643342, Functions.GammaLn(2.69286489486694), Accuracy);
        XCTAssertEqualWithAccuracy(2.59403131257292, Functions.GammaLn(4.60012321472168), Accuracy);
        XCTAssertEqualWithAccuracy(9.01512217041147E-02, Functions.GammaLn(2.18743028640747), Accuracy);
        XCTAssertEqualWithAccuracy(1.78957799295296, Functions.GammaLn(3.9982629776001), Accuracy);
        
        XCTAssertEqualWithAccuracy(39.3398841872, Functions.GammaLn(20), Accuracy);
        XCTAssertEqualWithAccuracy(365.123, Functions.GammaLn(101.3), 0.01);
        XCTAssertEqualWithAccuracy(1.82781, Functions.GammaLn(0.15), 0.01);
        
        
        XCTAssertEqualWithAccuracy(2.41605085099579, Functions.Gamma(3.19672372937202), Accuracy);
        XCTAssertEqualWithAccuracy(13.8825126879496, Functions.Gamma(4.62595878839493), Accuracy);
        XCTAssertEqualWithAccuracy(2.13271882732642, Functions.Gamma(0.415676707029343), Accuracy);
        XCTAssertEqualWithAccuracy(3.69810387443817, Functions.Gamma(3.59550366401672), Accuracy);
        XCTAssertEqualWithAccuracy(1.77273235949519, Functions.Gamma(2.86533065438271), Accuracy);
        XCTAssertEqualWithAccuracy(0.948430702927698, Functions.Gamma(1.85917609930038), Accuracy);
        XCTAssertEqualWithAccuracy(4.55022977456423, Functions.Gamma(3.77391051650047), Accuracy);
        XCTAssertEqualWithAccuracy(5.44572548650429, Functions.Gamma(3.92214500904083), Accuracy);
        XCTAssertEqualWithAccuracy(0.901097590334103, Functions.Gamma(1.65637829899788), Accuracy);
        XCTAssertEqualWithAccuracy(0.918635851663489, Functions.Gamma(1.74811812639236), Accuracy);
        
        XCTAssertEqualWithAccuracy(0.864664716763, Functions.GammaRegularized(1, x: 2), Accuracy);
        XCTAssertEqualWithAccuracy(0.999477741950, Functions.GammaRegularized(3, x: 12), Accuracy);
        XCTAssertEqualWithAccuracy(0.714943499683, Functions.GammaRegularized(5, x: 6), Accuracy);
        
        
    }
    
    func testErvInverse(){
        XCTAssertEqualWithAccuracy(0.2724627147267544, Functions.ErfInverse(0.3), Accuracy)
        XCTAssertEqualWithAccuracy(0.6040031879352371, Functions.ErfInverse(0.607), Accuracy)
        XCTAssertEqualWithAccuracy(0.1418558907268814, Functions.ErfInverse(0.159), Accuracy)
        XCTAssertEqualWithAccuracy(1.701751973779214, Functions.ErfInverse(0.9839), Accuracy)
        
    }
    
    func testInverseGammaRegularized(){
        XCTAssertEqualWithAccuracy(10, Functions.InverseGammaRegularized(0.5, y0: 0.99999225578356895592), Accuracy);
        XCTAssertEqualWithAccuracy(1, Functions.InverseGammaRegularized(1, y0: 0.63212055882855767840), Accuracy);
    }
    
    func testFibonacci(){
        XCTAssertEqual(5358359254990966640871840, Functions.Fibonacci(120))
    }
    
    func testFibonacciPerformance(){
        return;
        self.measureBlock() {
            let f =  Functions.Fibonacci(130) // 5secs +/- 10%
        }
    }
    
    func testFactorial(){
        XCTAssertEqualWithAccuracy(479001600, Functions.Factorial(12), Accuracy);
        XCTAssertEqualWithAccuracy(355687428096000, Functions.Factorial(17), Accuracy);
        XCTAssertEqualWithAccuracy(40320, Functions.Factorial(8), Accuracy);
        
        XCTAssertEqualWithAccuracy(19.9872144957, Functions.FactorialLn(12), Accuracy);
        XCTAssertEqualWithAccuracy(932.555207148, Functions.FactorialLn(213), Accuracy);
        XCTAssertEqualWithAccuracy(8.52516136107, Functions.FactorialLn(7), Accuracy);
    }
}