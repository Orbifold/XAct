//
//  ComplexNumber.swift
//  XAct
//
//  Created by Francois Vanderseypen on 2/26/15.
//  Copyright (c) 2015 Orbifold. All rights reserved.
//

import Foundation

/**
A structure for complex numbers.
*/
public struct ComplexNumber{
    public var Re:Double
    public var Im:Double
    
    init(re:Double, im:Double){
        self.Re = re
        self.Im = im
    }
    
    public static func IsNaN(z:ComplexNumber) -> Bool{  return z.IsNaN }
    
    public var IsNaN:Bool {get{ return self.Re == Double.NaN || self.Im == Double.NaN}}
    
    public static var NaN:ComplexNumber { get{ return ComplexNumber(re:Double.NaN, im:0)}}
    
    public var Conjugate:ComplexNumber{ get{ return ComplexNumber(re: self.Re, im:-self.Im)}}
    
    public var Norm:Double { get{
        if(IsNaN){ return Double.NaN}
            return sqrt(Re*Re + Im*Im)
        }}
}
var I = 1.I;
public extension Double{
    public var I:ComplexNumber{get{return ComplexNumber(re: 0,im: self) }}
}

public func +(u:Double, v:ComplexNumber) -> ComplexNumber{
    return ComplexNumber(re: u + v.Re, im: v.Im)
}
public func +(u:ComplexNumber, v:Double) -> ComplexNumber{
    return ComplexNumber(re: u.Re + v, im: u.Im)
}
public func +(u:ComplexNumber, v:ComplexNumber) -> ComplexNumber{
    return ComplexNumber(re: u.Re + v.Re, im: u.Im + v.Im)
}

public func -(u:Double, v:ComplexNumber) -> ComplexNumber{
    return ComplexNumber(re: u - v.Re, im: v.Im)
}
public func -(u:ComplexNumber, v:Double) -> ComplexNumber{
    return ComplexNumber(re: u.Re - v, im: u.Im)
}
public func -(u:ComplexNumber, v:ComplexNumber) -> ComplexNumber{
    return ComplexNumber(re: u.Re - v.Re, im: u.Im - v.Im)
}

public func *(u:Double, v:ComplexNumber) -> ComplexNumber{
    return ComplexNumber(re: u * v.Re, im: u*v.Im)
}
public func *(u:ComplexNumber, v:Double) -> ComplexNumber{
    return ComplexNumber(re: u.Re * v, im: u.Im*v)
}
public func *(u:ComplexNumber, v:ComplexNumber) -> ComplexNumber{
    return ComplexNumber(re: (u.Re * v.Re - u.Im*v.Im), im: (u.Re * v.Im + u.Im*v.Re))
}

public func ==(u:Double, v:ComplexNumber) -> Bool{
    return u == v.Re && v.Im == 0
}
public func ==(u:ComplexNumber, v:Double) -> Bool{
    return u.Re == v && u.Im == 0
}
public func ==(u:ComplexNumber, v:ComplexNumber) -> Bool{
    return u.Re == v.Re && u.Im == v.Im
}



public func Re(u:ComplexNumber) -> Double{
    if(u.IsNaN){ return Double.NaN}
    return u.Re;
}

public func Im(u:ComplexNumber) -> Double{
    if(u.IsNaN){ return Double.NaN}
    return u.Im;
}


public func Norm(u:ComplexNumber) -> Double{
    if(u.IsNaN){ return Double.NaN}
    return sqrt(u.Re*u.Re + u.Im*u.Im)
}

public func Conjugate(z:ComplexNumber) -> ComplexNumber{
    return ComplexNumber(re: z.Re, im: -z.Im)
}


public func /(u:Double, v:ComplexNumber) -> ComplexNumber{
    if(v==0){return ComplexNumber.NaN}
    return u*v.Conjugate/v.Norm
}
public func /(u:ComplexNumber, v:Double) -> ComplexNumber{
    if(v==0){ return ComplexNumber.NaN}
    return ComplexNumber(re: u.Re / v, im: u.Im/v)
}
public func /(u:ComplexNumber, v:ComplexNumber) -> ComplexNumber{
    if(v==0){return ComplexNumber.NaN}
    return  u*v.Conjugate/v.Norm
}

