//
//  MWCGenerator.swift
//  XAct
//
//  Created by Francois Vanderseypen on 1/28/15.
//  Copyright (c) 2015 Orbifold. All rights reserved.
//

import UIKit
public typealias DateTime = NSDate
struct Math {
    static var Pi:Double = 3.141592
    
}
// For some issues with the data types in this implementation see http://stackoverflow.com/questions/28186817/multiply-with-carry-in-swift
// Info about the algorithm can be found here: http://en.wikipedia.org/wiki/Random_number_generation
// Most of the code is originally from http://www.codeproject.com/Articles/25172/Simple-Random-Number-Generation
public class MultiplyWithCarryRandomGenerator
{
    
    struct Static {
        static var m_w:UInt32 = 521748629
        static var m_z:UInt32 = 762436069
    }
    
    class var m_w:UInt32{get{return Static.m_w } set{Static.m_w = newValue}};
    class var m_z:UInt32{get{return Static.m_z } set{Static.m_z = newValue}};
    
    class func SetSeed(u:UInt32, v:UInt32)
    {
        if(u != 0) {m_w = u;}
        if(v != 0) {m_z = v;}
    }
    
    class func SetSeed(u:UInt32)
    {
        m_w = u;
    }
    public class func  SetSeedFromSystemTime()
    {
        let dt = DateTime()
        let x = NSCalendar.currentCalendar().components(.CalendarUnitNanosecond,  fromDate: dt).nanosecond
        SetSeed(UInt32(x >> 16), v: UInt32(x % 4294967296));
    }
    
    
    private class func GetUInt32()->UInt32
    {
        m_z = 36969 * (m_z & 65535) + (m_z >> 16);
        m_w = 18000 * (m_w & 65535) + (m_w >> 16);
        return (m_z << 16) &+ m_w;
    }
    
    public class func GetUniform()->Double
    {
        return   ((Double(GetUInt32()) + 1.0) * 2.32830643545449e-10);
    }
    
    public class func GetUniform( max:Int)->Int
    {
        return GetUniform(0, max: max);
    }
    
    public class func GetUniform( min:Int, max:Int)->Int
    {
        return min + Int(GetUniform()) * ((max - min) + 1);
    }
    
    
    
    public class func GetNormal()->Double
    {
        // Use Box-Muller algorithm
        var u1:Double = GetUniform();
        var u2:Double = GetUniform();
        var r:Double = sqrt(-2.0 * log(u1));
        var theta:Double = 2.0 *  Math.Pi * u2;
        return r * sin(theta);
    }
    
    public class func GetNormal( mean:Double,   standardDeviation:Double)->Double
    {
        if(standardDeviation <= 0.0) {
            NSException(name:"Deviation error", reason:"Deviation must be positive", userInfo:nil).raise()
        }
        return mean + standardDeviation * GetNormal();
    }
    
    public class func GetExponential()->Double
    {
        return -log(GetUniform());
    }
    
    public class func GetExponential(mean:Double)->Double
    {
        if(mean <= 0.0) {
            NSException(name:"Mean error", reason:"Mean must be positive", userInfo:nil).raise()
        }
        return mean * GetExponential();
    }
    
    public class func GetGamma(  shape:Double, scale:Double)->Double
    {
        // Implementation based on "A Simple Method for Generating Gamma Variables"
        // by George Marsaglia and Wai Wan Tsang.  ACM Transactions on Mathematical Software
        // Vol 26, No 3, September 2000, pages 363-372.
        
        var d:Double, c:Double, x:Double, xsquared:Double, v:Double, u:Double;
        
        if(shape >= 1.0) {
            d = shape - 1.0 / 3.0;
            c = 1.0 / sqrt(9.0 * d);
            do {
                do {
                    x = GetNormal();
                    v = 1.0 + c * x;
                } while (v <= 0.0);
                v = v * v * v;
                u = GetUniform();
                xsquared = x * x;
                if(u < 1.0 - 0.0331 * xsquared * xsquared || log(u) < 0.5 * xsquared + d * (1.0 - v + log(v)))
                {return scale * d * v;}
            }while(true)
        } else if(shape <= 0.0) {
            NSException(name:"Shape error", reason:"Shape must be positive", userInfo:nil).raise()
        } else {
            var g:Double = GetGamma(shape + 1.0, scale: 1.0);
            var w:Double = GetUniform();
            return scale * g * pow(w, 1.0 / shape);
        }
        return 0; // this should not be necessary but XCode complains nevertheless
    }
    
    public class func GetChiSquare(  degreesOfFreedom:Double)->Double
    {
        // A chi squared distribution with n degrees of freedom
        // is a gamma distribution with shape n/2 and scale 2.
        return GetGamma(0.5 * degreesOfFreedom, scale: 2.0);
    }
    
    public class func GetInverseGamma(  shape:Double,  scale:Double)->Double
    {
        // If X is gamma(shape, scale) then
        // 1/Y is inverse gamma(shape, 1/scale)
        return 1.0 / GetGamma(shape,scale: 1.0 / scale);
    }
    
    public class func GetWeibull(  shape:Double,   scale:Double)->Double
    {
        if(shape <= 0.0 || scale <= 0.0)
        {
            NSException(name:"Weibull error", reason:"Shape and scale must be positive", userInfo:nil).raise()
        }
        return scale * pow(-log(GetUniform()), 1.0 / shape);
    }
    
    public class func GetCauchy(  median:Double,   scale:Double)->Double
    {
        if(scale <= 0) {
            NSException(name:"Cauchy error", reason:"Scale must be positive", userInfo:nil).raise()
        }
        
        var p = GetUniform();
        
        // Apply inverse of the Cauchy distribution function to a uniform
        return median + scale * tan( Math.Pi * (p - 0.5));
    }
    
    public class func GetStudentT(  degreesOfFreedom:Double)->Double
    {
        if(degreesOfFreedom <= 0) {
            NSException(name:"Student error", reason:"DegreesOfFreedom must be positive", userInfo:nil).raise()
        }
        
        // See Seminumerical Algorithms by Knuth
        var y1 = GetNormal();
        var y2 = GetChiSquare(degreesOfFreedom);
        return y1 / sqrt(y2 / degreesOfFreedom);
    }
    
    public class func GetLaplace(  mean:Double, scale:Double) ->Double
    {
        var u = GetUniform();
        return (u < 0.5) ?
            mean + scale * log(2.0 * u) :
            mean - scale * log(2 * (1 - u));
    }
    
    public  class func  GetLogNormal(  mu:Double,   sigma:Double)->Double
    {
        return exp(GetNormal(mu, standardDeviation: sigma));
    }
    
    public  class func GetBeta(  a:Double, b:Double) -> Double
    {
        if(a <= 0.0 || b <= 0.0) {
            NSException(name:"Beta error", reason:"Values must be positive", userInfo:nil).raise()
        }
        
        var u = GetGamma(a, scale: 1.0);
        var v = GetGamma(b, scale: 1.0);
        return u / (u + v);
    }
    
    public class func GetPower(  a:Double,  min:Double = 1.0) ->Double
    {
        var u = GetUniform();
        return min * pow(1.0 - u, -1.0 / (a - 1.0));
    }
}

