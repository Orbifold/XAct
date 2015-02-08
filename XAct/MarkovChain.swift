//
//  MarkovChain.swift
//  XAct
//
//  Created by Francois Vanderseypen on 2/7/15.
//  Copyright (c) 2015 Orbifold. All rights reserved.
//

import Foundation

class MarkovChain<T:Hashable>{
    
    var root:MarkovLink<T>
    var length:Int;
    
    var Root:MarkovLink<T> { get{ return self.root}}
    
    init(rootInstance:T){
        root = MarkovLink<T>(data: rootInstance)
        self.length = 0
    }
     
    init(rootInstance:T, input:SequenceOf<T>,length:Int){
        self.length = length;
        self.root = MarkovLink<T>(data: rootInstance)
        self.root.Process(input, length: length);
    }
    
    func  Generate(size:Int) -> SequenceOf<T>
    {
        var ar = [T]()
        var gen = self.root.Generate(self.root.SelectRandomLink().Data, length: self.length, max: size)
        for d in gen
        {
            ar.append(d.Data)
        }
        return SequenceOf<T>(ar);
    }
}