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
    
    /**
    Returns the value of pi.
    */
    public static var Pi:Double {get{return Constants.Pi}} // with an insane number of digits really
    
    /**
    Returns a random number uniformly distributed across the [0, 1] interval.
    */
    public static func Random() -> Double{
        return MultiplyWithCarryRandomGenerator.GetUniform()
    }
    
    /**
    Returns a random integer within the given interval.
    */
    public static func Random(min:Int,max:Int) -> Int{
        return MultiplyWithCarryRandomGenerator.GetUniform(min,max: max);
    }
    
    /**
    Returns the sine of the given angle (in radians)
    */
    public static func Sin(x:Double) -> Double{
        return sin(x)
    }
    
    /**
    Returns the sine of the given angle sequence (in radians)
    */
    public static func Sin(seq:SequenceOf<Double>) -> SequenceOf<Double>{
        return SequenceOf<Double>(map(seq,{sin($0)}))
    }

    /**
   Returns the square root of the given angle (in radians)
   */
    public static func Sqrt(x:Double) -> Double{
        return sqrt(x)
    }

    /**
   Returns the square root of the given angle sequence (in radians)
   */
    public static func Sqrt(seq:SequenceOf<Double>) -> SequenceOf<Double>{
        return SequenceOf<Double>(map(seq,{sqrt($0)}))
    }
}