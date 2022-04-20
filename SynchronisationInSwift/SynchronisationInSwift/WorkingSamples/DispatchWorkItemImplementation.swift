//
//  DispatchWorkItem.swift
//  Dispatch_operation
//
//  Created by Laxmi Ganesh on 12/04/22.
//

import Foundation

struct DispatchWorkItemImplementation {
    
    func addDispatchQueue() {
        
        let queue = DispatchQueue(label: "com.swiftpal.dispatch.workItem")
        
        let workItem = DispatchWorkItem() {
            print("Stored task")
        }
        
        //Task 1
        queue.async(execute: workItem)
        // Task 2
        queue.asyncAfter(deadline: DispatchTime.now(), execute: workItem)
        // work item cancel
        workItem.notify(queue: queue, execute: workItem)
        // Task 3
        queue.async(execute: workItem)
        
        if workItem.isCancelled {
            print("Task was cancelled")
        }
        
    }
    
    func example1() {
        let item1 = DispatchWorkItem() {
            print("Inside the item 1")
        }
        
        let item2 = DispatchWorkItem() {
            print("Inside the item 2")
        }
        
        let queue = DispatchQueue(label: "com.domain.app.requests")
        let group = DispatchGroup()
        
        let itemsToExecute: [DispatchWorkItem] = [item1, item2]
        
        itemsToExecute.forEach {
            queue.async(group: group, execute: $0)
        }
        
        group.notify(queue: .main) {
            print("all work item done")
        }
    }
    
    func example2() {
        let queue = DispatchQueue.global()
        
        var item: DispatchWorkItem?
        
        item = DispatchWorkItem{
            for i in 0...1000 {
                if item?.isCancelled ?? true { break }
                print(i)
            }
            item = nil // resolve strong reference cycle of the dispatch work item
        }
        
        queue.async(execute: item!)
        //after five seconds, stop it if it hasn't already
        queue.asyncAfter(deadline: .now() + 5) {
            item?.cancel()
            item = nil
        }
    }
}
