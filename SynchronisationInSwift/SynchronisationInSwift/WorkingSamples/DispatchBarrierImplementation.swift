//
//  DispatchBarrierImplementation.swift
//  Dispatch_operation
//
//  Created by Laxmi Ganesh on 12/04/22.
//

import Foundation

struct DispatchBarrierImplementation {
    
    func example1() {
        var value = 2
        let concurrentQueue = DispatchQueue(label: "queue", attributes: .concurrent)
        
        concurrentQueue.async(flags: .barrier) {
            for i in 0...3 {
                value = i
                print("\(value)    ")
            }
        }
        
        concurrentQueue.async {
            print(value)
        }
        
        concurrentQueue.async(flags: .barrier) {
            for j in 4...6 {
                value = j
                print("\(value)   😃")
            }
        }
        
        concurrentQueue.async {
            value = 14
            print(value)
        }
    }
    
    let queueCzonc = DispatchQueue(label: "Barrier test", attributes: .concurrent)
    
    func example2() {
        
        for i in 0...10 {
            
            DispatchQueue.global(qos: .background).async {
                syncProcess(index: i)
            }
            
            DispatchQueue.global(qos: .background).async {
                asyncBarrier(index: i)
            }
            
            
        }
        
    }
    
    private func syncProcess(index: Int) {
        queueCzonc.sync {
            print("Sync \(index) called")
        }
    }
    
    func asyncBarrier(index: Int) {
        queueCzonc.async(flags: .barrier) {
            print("Async barrier \(index) called")
        }
    }
}
