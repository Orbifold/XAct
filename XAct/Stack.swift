//
//  Stack.swift
//  XAct
//
//  Created by Francois Vanderseypen on 2/11/15.
//  Copyright (c) 2015 Orbifold. All rights reserved.
//

import Foundation
/**
First in last out data structure.
*/
public class Stack<TData> {
    
    private var top: LinkedListNode<TData>!
    private var count:Int;
    public var Count:Int{get{return self.count;}}
    
    /**
    Gets whether this stack is empty.
    */
    public var IsEmpty: Bool {
        get{ return self.count == 0;}
    }

    init(){
        self.count = 0;
    }
    
    /**
    Pushes the given item on top of the stack.
    */
    func Push(var key: TData) {
        
        if (top == nil) {
            top = LinkedListNode<TData>()
        }
        
        if (top.key == nil){
            top.key = key;
        }
        else {
            var nexNode = LinkedListNode<TData>()
            nexNode.key = key
            nexNode.next = top;
            top = nexNode;
        }
        self.count++;
    }
    
    /**
    Removes the item at the top of the stack.
    */
    func Pop() -> TData? {
        
        let topitem: TData? = self.top?.key
        
        if (topitem == nil){
            return nil
        }
        
        var queueitem: TData? = top.key!
        
        if let nextitem = top.next {
            top = nextitem
        }
        else {
            top = nil
        }
        self.count--;
        return queueitem
        
    }
    
    /**
    Returns the item at the top of the stack without removing it.
    */
    func Peek() -> TData? {
        
        if let topitem  = self.top?.key {
            return topitem
        }            
        else {
            return nil
        }
        
    }
   }