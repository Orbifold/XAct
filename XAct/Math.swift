//
//  Math.swift
//  XAct
//
//  Created by Francois Vanderseypen on 2/7/15.
//  Copyright (c) 2015 Orbifold. All rights reserved.
//

import Foundation

/**
A collection of standard math utils.

:seeAlso: Constants and Functions classes
*/
public struct Math {
    
    public static var Pi:Double {get{return Constants.Pi}}
    
    public static func Random() -> Double{
        return MultiplyWithCarryRandomGenerator.GetUniform()
    }
    
    public static func Random(min:Int,max:Int) -> Int{
        return MultiplyWithCarryRandomGenerator.GetUniform(min,max: max);
    }
    
    public static func Sin(x:Double) ->Double{
        return sin(x)
    }
    
    public static func Sin(seq:SequenceOf<Double>) -> SequenceOf<Double>{
        return SequenceOf<Double>(map(seq,{sin($0)}))
    }
}