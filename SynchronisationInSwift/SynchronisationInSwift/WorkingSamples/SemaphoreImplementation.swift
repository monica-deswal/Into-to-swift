//
//  Semaphore.swift
//  Dispatch_operation
//
//  Created by Laxmi Ganesh on 12/04/22.
//

import Foundation

struct SemaphoreImplementation {
    
    var value = 2
    let concurrentQueue = DispatchQueue(label: "queue", attributes: .concurrent)
    let semahpore = DispatchSemaphore(value: 1)
    
    func sameExampleGroup() {
        let dq1 = DispatchQueue(label: "q1", attributes: .concurrent)
        let dq2 = DispatchQueue(label: "q2", attributes: .concurrent)
        let group = DispatchGroup()
        
        for i in 1...3 {
            group.enter()
            dq1.async {
                print("\(#function) DispatchQueue 1: \(i)")
                group.leave()
            }
        }
        
        for i in 1...3 {
            group.enter()
            dq2.async {
                print("\(#function) Dispatch queue 2: \(i)")
                group.leave()
            }
        }
        
        group.notify(queue: DispatchQueue.main) {
            print("done by group")
        }
    }
    
    func sameExampleSemaphore() {
        let dq1 = DispatchQueue(label: "q1", attributes: .concurrent)
        let dq2 = DispatchQueue(label: "q2", attributes: .concurrent)
        let semaphore = DispatchSemaphore(value: 1)
        
        for i in 1...3 {
            dq1.async {
                _ = semaphore.wait(timeout: DispatchTime.distantFuture)
                print("\(#function) Dispatch queue 1: \(i)")
                semaphore.signal()
            }
        }
        
        for i in 1...3 {
            dq2.async {
                _ = semaphore.wait(timeout: DispatchTime.distantFuture)
                print("\(#function) DispatchQueue 2: \(i)")
                semaphore.signal()
            }
        }
    
    }
    
    func example1() {
        
        let queue = DispatchQueue(label: "com.gcd.myQueue", attributes: .concurrent)
        let semaphore = DispatchSemaphore(value: 3)
        
        for i in 0..<15 {
            queue.async {
                let songNumber = i + 1
                semaphore.wait()
                print("Downloading song", songNumber)
                sleep(2)
                print("Downloaded song", songNumber)
                semaphore.signal()
            }
        }
    }
    
    
}
