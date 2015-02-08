//
//  MarkovLink.swift
//  XAct
//
//  Created by Francois Vanderseypen on 2/5/15.
//  Copyright (c) 2015 Orbifold. All rights reserved.
//

import Foundation
/**
An element of a Markov chain.
*/
class MarkovLink<T:Hashable>{
    var data:T
    var count:Int
    var links:[T: MarkovLink<T>]
    
    init(data:T){
        self.data = data
        self.count = 0
        self.links = [T: MarkovLink<T>]()
    }
    
    func Generate(start:T, length:Int, var max:Int) -> SequenceOf<MarkovLink<T>>
    {
        var window =  Queue<T>(capacity: length);
        
        window.enQueue(start);
        var seq = [MarkovLink<T>]();
        var link = self.Find(SequenceOf<T>(window));
        while(link != nil && max != 0) {
            var next = link!.SelectRandomLink();
            seq.append(link!)
            if(window.count == length - 1){
                window.deQueue();
            }
            
            window.enQueue(next.Data);
            
            link = self.Find(SequenceOf<T>(window));
            max--;
        }
        return SequenceOf<MarkovLink<T>>(seq);
    }
    
    func Process( input:SequenceOf<T>, length:Int)
    {
        // holds the current window
        var window = Queue<T>(capacity: length);
        
        // process the input, a window at a time (overlapping)
        for part in input
        {
            if (window.count == length){
                window.deQueue();
            }
            window.enQueue(part);
            
            self.ProcessWindow(window);
        }
    }
    func Process(part:T) -> MarkovLink<T>
    {
        var link = self.Find(part);
        
        if (link == nil)
        {
            link =  MarkovLink<T>(data: part);
            self.links[part] = link;
        }
        
        link!.Seen();
        
        return link!;
    }
    
    func SelectRandomLink() -> MarkovLink<T>
    {
        var markovLink:MarkovLink<T>?;
        
        var universe = self.ChildOccurances;
        
        // select a random probability
        var rnd = Math.Random(1, max: universe + 1);
        
        // match the probability by treating
        // the followers as bands of probability
        var total = 0;
        for child in self.links.values
        {
            total += child.Occurances;
            
            if (total >= rnd)
            {
                markovLink = child;
                break;
            }
        }
        
        return markovLink!;
    }
    var ChildOccurances:Int
        {
        get
        {
            // sum all followers occurances
            var sum:Int = 0;
            for link in self.links.values{
                sum += link.Occurances
            }
            //var result = self.links.Sum(link => link.Value.Occurances);
            
            return sum;
        }
    }
    var Data:T{
        get{return self.data}
        set{ self.data = newValue}
    }
    
    var Occurances:Int {
        get
        {
            return self.count;
        }
    }
    
    func Seen(){
        self.count++
    }
    
    func Find( follower:T) -> MarkovLink<T>?
    {
        var markovLink:MarkovLink<T>?;
        
        if let key = self.links.indexForKey(follower){
            markovLink = self.links[follower]!;
        }
        
        return markovLink;
    }
    
    func Find(window:SequenceOf<T>) -> MarkovLink<T>?
    {
        var link:MarkovLink<T>? = self;
        
        for part in window
        {
            link = link!.Find(part);
            
            if (link == nil){
                break;
            }
        }
        
        return link;
    }
    func  ProcessWindow( window:Queue<T>)
    {
        var link = self;
        for part in window{
            link = link.Process(part)
        }
        
        //link = window.Aggregate(link, (current, part) => current.Process(part));
    }
    
}

