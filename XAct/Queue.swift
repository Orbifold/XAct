//
//  Queue.swift
//  XAct
//
//  Created by Francois Vanderseypen on 2/5/15.
//  Copyright (c) 2015 Orbifold. All rights reserved.
//

import Foundation

/**
An implementation of the FIFO data structure.
*/
public class Queue<T> : SequenceType{
    var capacity:Int
    private var top: QNode<T>! = QNode<T>()
    
    init(){
        self.capacity = Int.max
    }
    
    init(capacity:Int){
        self.capacity = capacity
    }
    
    init(array:[T]){
        self.capacity = Int.max
        for s in array { self.enQueue(s)}
    }
    
    public func generate() -> QueueGenerator<T>{
        
        return QueueGenerator<T>(q: self.top);
    }
    
    //the number of items
    var count: Int {
        if (top.key == nil) {
            return 0
        }
        else {
            var current: QNode<T> = top
            var x: Int = 1
            while (current.next != nil) {
                current = current.next!;
                x++
            }
            return x
        }
    }
    
    func enQueue(seq:SequenceOf<T>){
        for s in seq{ self.enQueue(s)}
    }
    
    func enQueue(key: T) {
        
        if(count >= self.capacity){
            NSException(name:"Queue error", reason:"The Queue is over capacity.", userInfo:nil).raise()
            return
        }
        if (top == nil) {
            top = QNode<T>()
        }
        
        if (top.key == nil) {
            top.key = key;
            return
        }
        
        var childToUse: QNode<T> = QNode<T>()
        var current: QNode = top
        while (current.next != nil) {
            current = current.next!
        }
        childToUse.key = key;
        current.next = childToUse;
    }
    
    
    /**
    Retrieves the top most item without dequeueing it.
    */
    func peek() -> T? {
        return top.key!
    }
    
    
    /**
    Dequeues the top most item.
    */
    func deQueue() -> T? {
        
        
        //determine if the key or instance exist
        let topitem: T? = self.top?.key
        
        if (topitem == nil) {
            return nil
        }
        
        //retrieve and queue the next item
        var queueitem: T? = top.key!
        
        
        //use optional binding
        if let nextitem = top.next {
            top = nextitem
        }
        else {
            top = nil
        }
        
        
        return queueitem
        
    }
    
    
    //check for the presence of a value
    func isEmpty() -> Bool {
        
        //determine if the key or instance exist
        if let topitem: T = self.top?.key {
            return false
        }
            
        else {
            return true
        }
        
    }
    
}
/**
The iterator for the Queue structure.
*/
public class QueueGenerator<T>: GeneratorType {
    
    private var current:QNode<T>?
    
    init(q:QNode<T>) {
        self.current = q
    }
    
    public func next() -> T? {
        var r = self.current;
        if let c = self.current {
            
            self.current = c.next;
        }
        else{
            return nil
        }
        return r!.key!
    }
}

class QNode<T> {
    
    var key: T? = nil
    var next: QNode? = nil
    
}
