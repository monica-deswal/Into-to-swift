//
//  OperationsImplementation.swift
//  Dispatch_operation
//
//  Created by Laxmi Ganesh on 19/04/22.
//

import Foundation

struct OperationsImplementation {
    
    func systemDefinedOperation() {
        
        let blockOperation = BlockOperation {
            print("Executing")
        }
        
        let queue = OperationQueue()
        queue.addOperation(blockOperation)
        
        //==============
        
        queue.addOperation {
            print("Executing !!")
        }
    }
}

final class ContentImportOperation: Operation {
    
    let itemProvider: NSItemProvider
    
    init(itemProvider: NSItemProvider) {
        self.itemProvider = itemProvider
        super.init()
    }
    
    override func main() {
        guard !isCancelled else { return }
        print("Importing content..")
    }
}

extension OperationsImplementation {
    
    func blockOperation() {
        
        let operation = BlockOperation {
            
            for i in 0...10 {
                print("\(i)")
                print(Unmanaged.passUnretained(Thread.current).toOpaque())
                print(Thread.isMainThread)
            }
        }
        
        operation.start()
    }
    
    func blockOperationOnMainThread() {
        let operation = BlockOperation()
        
        operation.addExecutionBlock {
            for i in 0...10 {
                print("  😡\(i)")
                
            }
        }
        
        operation.addExecutionBlock {
            for i in 0 ... 10 {
                print("  😥😡\(i)")
            }
        }
        
      //  DispatchQueue.main.async {
            operation.start()
       // }
    }
    
    func backgroundThreadBlockOperation() {
        let operation = BlockOperation()
        
        operation.addExecutionBlock {
            for i in 0...10 {
                print("  😰😡\(i)")
            }
        }
        
        operation.addExecutionBlock {
            for i in 0...10 {
                print("  😡😰\(i)")
            }
        }
        
        DispatchQueue.global(qos: .background).async {
            print(" 😈Running on thread \(Thread.current)")
            operation.start()
            print("o👻ur operation.starr() \(Thread.current) will block me please help")
        }
        
        print("This will called now")
    }
    
    func addCompletionOperation() {
        let operation = BlockOperation()
        operation.completionBlock = {
            print("👻Finished on thread \(Thread.current)")
        }
        
        operation.addExecutionBlock {
            for i in 0 ... 10 {
                print("👻\(i)")
            }
        }
        
        operation.addExecutionBlock {
            for i in 0...10 {
                print("💀\(i)")
            }
        }
        
        DispatchQueue.global(qos: .background).async {
            print("👻running on thread \(Thread.current)")
            operation.start()
        }
        print("👻This will called now \(Thread.current) \(Thread.isMainThread)")
    }
}
