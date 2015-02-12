//
//  LinkedList.swift
//  XAct
//
//  Created by Francois Vanderseypen on 2/11/15.
//  Copyright (c) 2015 Orbifold. All rights reserved.
//

import Foundation

public class LinkedListNode<TData> {
    
    var key: TData! = nil
    var next: LinkedListNode? = nil
    var previous: LinkedListNode? = nil
}
/**
A strcuture of nodes linked together forming a sequence.
*/
public class LinkedList<TData: Equatable> {
    
    private var head: LinkedListNode<TData>!
    var count:Int;
    init(){
        self.count = 0
        self.head = nil
    }
    /**
    Adds an item to the list.
    */
    func AddLink(key: TData) {
        if(head == nil){
            head = LinkedListNode<TData>()
        }
        if (head.key == nil) {
            head.key = key;
        }
        else{
            var current:LinkedListNode? =  head
            while (current != nil) {
                if (current?.next == nil) {
                    var nextNode: LinkedListNode = LinkedListNode<TData>()
                    nextNode.key = key;
                    nextNode.previous = current
                    current!.next = nextNode;
                    break
                }
                    
                else {
                    current = current?.next
                }
                
            }
        }
        self.count++
    }
    
    var Head:LinkedListNode<TData>! { get{return self.head}}
    
    func RemoveAt(index: Int) {
        var current: LinkedListNode<TData>? =  head
        var trailer: LinkedListNode<TData>? = nil
        var listIndex: Int = 0
        
        if (index == 0) {
            current = current?.next
            head = current!
            count--
            return
        }
        while (current != nil) {
            
            if (listIndex == index) {
                trailer!.next = current?.next
                current = nil
                count--
                break;
            }
            trailer = current
            current = current?.next
            listIndex++
        }
    }
    
    func Insert(key: TData, index: Int) {
        if (head.key == nil) {
            head.key = key;
            return;
        }
        var current: LinkedListNode<TData>? = head
        var trailer: LinkedListNode<TData>? = nil
        var listIndex: Int = 0
        
        while (current != nil) {
            
            if (index == listIndex) {
                
                var childToUse: LinkedListNode = LinkedListNode<TData>()
                childToUse.key = key;
                childToUse.next = current
                childToUse.previous = trailer
                
                if let linktrailer = trailer {
                    linktrailer.next = childToUse
                    childToUse.previous = linktrailer
                }
                current!.previous = childToUse
                
                if (index == 0) {
                    head = childToUse
                }
                count++
                break
                
            }
            trailer = current
            current = current?.next
            listIndex += 1
        }
        
    }
    
    
}