//
//  CustomOperationImplementation.swift
//  SynchronisationInSwift
//
//  Created by Laxmi Ganesh on 26/04/22.
//

import Foundation

class CustomOperationImplementation: Operation {
    
    func basicOperationImplementation() {
        let operation = CustomOperationImplementation()
        operation.start()
    }
    
    
    func addOperationQueue() {
        let operation = CustomOperationImplementation()
        operation.addOperationOnQueue()
    }
    
    
    
    
}

extension CustomOperationImplementation  {
    
  //  ==================================
//    override func main() {
    // main thread
//        for i in 0...10 {
//            print("Ꮏ \(i)")
//            print(Thread.isMainThread)
//        }
//    }
    
    // =============================
    
    override func start() {
        if isCancelled { return }
        Thread.init(block: main).start()
    }

    override func main() {
        // background thread
        for i in 0 ... 9000 {
            if isCancelled {
                print("🏡 \(i)")
                print(Thread.isMainThread)
            }
        }
    }
    
   // ====================================
    
    func addOperationOnQueue() {
        let operationQueue = OperationQueue()
        
        let blockOperation1 = BlockOperation {
            for i in 0 ... 4 {
                print("🐣 \(i)")
                print(Thread.isMainThread)
            }
        }
        
        let blockOperation2 = BlockOperation {
            for i in 0 ... 4 {
                print("🦄 \(i)")
                print(Thread.isMainThread)
            }
        }
        
        operationQueue.addOperation(blockOperation1)
        operationQueue.addOperation(blockOperation2)
    }
    
    func addMaxconcurrentQueueOnOperation() {
        let operationQueue = OperationQueue()
        
        let blockOperation1 = BlockOperation {
            for i in 0 ... 4 {
                print("🐣 \(i)")
                print(Thread.isMainThread)
            }
        }
        
        let blockOperation2 = BlockOperation {
            for i in 0 ... 4 {
                print("🦄 \(i)")
                print(Thread.isMainThread)
            }
        }
        
        operationQueue.maxConcurrentOperationCount = 1
        operationQueue.addOperation(blockOperation1)
        operationQueue.addOperation(blockOperation2)
    }
    
    func addDependencyOnOperarionQueue() {
        let operationQueue = OperationQueue()
        
        let blockOperation1 = BlockOperation {
            for i in 0 ... 4 {
                print("🐣 \(i)")
                print(Thread.isMainThread)
            }
        }
        
        let blockOperation2 = BlockOperation {
            for i in 0 ... 4 {
                print("🦄 \(i)")
                print(Thread.isMainThread)
            }
        }

        blockOperation1.addDependency(blockOperation2)
        operationQueue.maxConcurrentOperationCount = 1
        operationQueue.addOperation(blockOperation1)
        operationQueue.addOperation(blockOperation2)
    }
    
    func dispatchGroupImplementationWithOperations() {
        let operationQueue = OperationQueue()
        
        let blockOoperation1 = BlockOperation {
            for i in 0 ... 10 {
                print("🦑 \(i)")
            }
        }
        
        let blockOperation2 = BlockOperation {
            for i in 0 ... 10 {
                print("🦐 \(i)")
            }
        }
        
        let blockOperation3 = BlockOperation {
            for i in 0 ... 10 {
                print("🦞 \(i)")
            }
        }
        
        let blockOperation4 = BlockOperation {
            print("All operation is completed")
        }
        
        operationQueue.maxConcurrentOperationCount = 4
        blockOperation4.addDependency(blockOoperation1)
        blockOperation4.addDependency(blockOperation2)
        blockOperation4.addDependency(blockOperation3)
        
        operationQueue.addOperations([blockOoperation1, blockOperation2, blockOperation3, blockOperation4], waitUntilFinished: false)
        
    }
    
    func dispatchGroupImplementationWithOperationsOnMainThread() {
        let operationQueue = OperationQueue()
        
        let blockOoperation1 = BlockOperation {
            for i in 0 ... 10 {
                print("🦑 \(i)")
            }
        }
        
        let blockOperation2 = BlockOperation {
            for i in 0 ... 10 {
                print("🦐 \(i)")
            }
        }
        
        let blockOperation3 = BlockOperation {
            for i in 0 ... 10 {
                print("🦞 \(i)")
            }
        }
        
        let blockOperation4 = BlockOperation {
            print("All operation is completed")
        }
        
        operationQueue.maxConcurrentOperationCount = 4
        blockOperation4.addDependency(blockOoperation1)
        blockOperation4.addDependency(blockOperation2)
        blockOperation4.addDependency(blockOperation3)
        
        operationQueue.addOperations([blockOoperation1, blockOperation2, blockOperation3, blockOperation4], waitUntilFinished: true)
        
    }
    
    func addoperationOnBackgroundThread() {
        DispatchQueue.global().async {
            
            let operationQueue = OperationQueue()
            operationQueue.maxConcurrentOperationCount = 4
            
            let blockOperartion1 = BlockOperation {
                for i in 0 ... 9000 {
                    print("🐶 \(i)")
                }
            }
            
            let blockOperartion2 = BlockOperation {
                for i in 0 ... 9000 {
                    print("🐱 \(i)")
                }
            }
            
            let blockOperation3 = BlockOperation {
                for i in 0 ... 9000 {
                    print("🐭 \(i)")
                }
            }
            
            operationQueue.addOperations([blockOperartion1, blockOperartion2, blockOperation3], waitUntilFinished: true)
            print("All operartion is completed")
        }
    }
    
    func addCocurrentOperation() {
        let operarionQueue = OperationQueue()
        
        let operation1 = BlockOperation {
            self.someTaskOne()
        }
        
        let operation2 = BlockOperation {
            self.someTaskTwo()
        }
        
        operation2.addDependency(operation1)
        operarionQueue.addOperation(operation1)
        operarionQueue.addOperation(operation2)
    }
    
    func someTaskOne() {
        print(Thread.isMainThread)
        let queue = DispatchQueue(label: "dd", attributes: .concurrent)
        queue.async {
            for i in 0 ... 10 {
                print("🐱 \(i)")
            }
        }
    }
    
    func someTaskTwo() {
        print(Thread.isMainThread)
        let queue = DispatchQueue(label: "dd", attributes: .concurrent)
        queue.async {
            for i in 0 ... 10 {
                print("🐯 \(i)")
            }
        }
    }
}
