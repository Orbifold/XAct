//
//  Extensions.swift
//  XAct
//
//  Created by Francois Vanderseypen on 2/5/15.
//  Copyright (c) 2015 Orbifold. All rights reserved.
//

import Foundation

public extension String{

    /**
    Returns the number of characters in the string.
    */
    var length:Int {
        get {
            return Array(self).count
        }
    }
    
    /**
    Trim the start and trailing spaces.
    */
    public func Trim() -> String{
        return self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
    }
    
    /**
    Search and replace of the given strings.
    */
    public func Replace(searchFor:String, replaceWith:String) -> String{
        return self.stringByReplacingOccurrencesOfString(searchFor, withString: replaceWith)
    }
    
    /**
    Returns the elements of the string by spliting with the given string.
    */
    public func Split(separator:String) -> [String]{
        return self.componentsSeparatedByString(separator)
    }
}

/**
Epsilon extensions of the Double type.
*/
public extension Double{
    /**
    Returns whether the number is close to zero.
    
    :param: accuracy The threshold within which the number is considered zero. Default is Epsilon.
    */
    public func IsZero(accuracy:Double = Constants.Epsilon) -> Bool{
        return abs(self) < accuracy;
    }
    
    /**
    Returns whether the number is considered of measure zero.
    */
    public func IsVerySmall() -> Bool{
        return abs(self) < Constants.Epsilon;
    }
    
    /**
    Returns whether the number is equal to the given number in an Epsilon sense.
    */
    public func IsEqualTo(value:Double) -> Bool
    {
        return abs(self - value) < Constants.Epsilon;
    }
    
    /**
    Returns whether the number is close to the given one in an Epsilon sense.
    */
    public func AreClose(value:Double) -> Bool
    {
        return self.IsEqualTo(value) || Double.IsVerySmall(self - value)();
    }
    
    /**
    Returns whether the number is not close to the given one in an Epsilon sense.
    */
    public func AreNotClose(value:Double) -> Bool
    {
        return !self.AreClose(value)
    }
    
    /**
    Returns whether the number is less than or close to the given one in an Epsilon sense.
    */
    public func IsLessThanOrClose(value:Double) -> Bool
    {
        return self < value || self.AreClose(value);
    }
}


