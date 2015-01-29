//
//  Numbers.swift
//  XAct
//
//  Created by Francois Vanderseypen on 1/29/15.
//  Copyright (c) 2015 Orbifold. All rights reserved.
//

import Foundation

public class Numbers{

    
    /**
    Returns whether the provided integer is an even number.
    
    :param: number The number to check. 
    :returns: true if and only if the given number is not min, max or odd.
    */
    public class func IsEven(number:Int) -> Bool{
        if(number==Int.max || number == Int.min){
            return false
        }
        return (number & 0x1) == 0x0;
    }
    
    /**
    Truncates the specified number by dropping its decimals.
    
    :param: number The number to truncate.
    */
    public class func Truncate(number:Double) -> Double
    {
        if (abs(number) < Constants.Epsilon){ return 0.0 }
        return number < 0 ? ceil(number) : floor(number);
    }
}