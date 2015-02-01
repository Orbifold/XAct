//
//  Numbers.swift
//  XAct
//
//  Created by Francois Vanderseypen on 1/29/15.
//  Copyright (c) 2015 Orbifold. All rights reserved.
//

import Foundation
import Accelerate
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
    Returns whether the provided integer is an odd number.
    
    :param: number The number to check.
    :returns: true if and only if the given number is not min, max or even.
    */
    public class func IsOdd(number:Int) -> Bool{
        if(number==Int.max || number == Int.min){
            return false
        }
        return (number & 0x1) == 0x1;
    }
    
    /**
    Returns whether the provided integer is a power of two.
    
    :param: number The number to check.
    */
    public class func IsPowerOfTwo(number:Int) -> Bool{
        if(number==Int.max || number == Int.min){
            return false
        }
        return number > 0 && (number & (number - 1)) == 0x0;
    }
    
    /**
        Returns the closest perfect power of two that is larger or equal to the provided 32-bit integer.
    
        FIXME: not sure how to make this work for generic Int
    */
    public class func CeilingToPowerOfTwo(number:Int32) -> Int32{
        
        if (number == Int32.max) {return 0;}
        
        let MaxPowerOfTwo:Int32 = 0x40000000;
        if (number > MaxPowerOfTwo) {
            NSException(name:"Numbers error", reason:"Given number cannot be larger than 0x40000000.", userInfo:nil).raise()
        }
        var n = number
        n -= 1;
        n |=   n >> 1;
        n |= n >> 2;
        n |= n >> 4;
        n |= n | n >> 8;
        n |= n >> 16;
        return n + 1;
    }

    /**
        Returns the greatest common divisor of the given numbers.
    */
    public class func GreatestCommonDivisor(integers:Int...) -> Int{
        if (integers.count == 0) {
            NSException(name:"GreatestCommonDivisor error", reason:"Given list cannot be empty.", userInfo:nil).raise()
        }
        if(integers.count == 1){ return integers[0]}
        if(integers.count == 2){
            if (integers[1] != 0) {
                return GreatestCommonDivisor(integers[1], integers[0] % integers[1])
            } else {
                return abs(integers[0])
            }
        }
        var gcd = abs(integers[0]);
        
        for(var k = 1; k<integers.count && gcd>1; k++){
            gcd = GreatestCommonDivisor(gcd, integers[k]);
        }
        return gcd
    }
    
    /**
        Returns the least common multiple of the given numbers.
    */
    public class func LeastCommonMultiple(integers:Int...) -> Int{
        if(integers.count == 1){ return integers[0]}
        if(integers.count == 2){
            return abs(integers[0] * integers[1]) / GreatestCommonDivisor(integers[0], integers[1])
        }
        var lcm = abs(integers[0]);
        for (var i = 1; i < integers.count; i++) {lcm = LeastCommonMultiple(lcm, integers[i]);}
        return lcm;
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