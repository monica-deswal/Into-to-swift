//
//  DispatchGroup.swift
//  Dispatch_operation
//
//  Created by Laxmi Ganesh on 12/04/22.
//

import Foundation

struct DispatchGroupImplementation {
    
    private func firstFunction(completion: @escaping() -> Void) {
        
        for i in 1...5 {
            sleep(1)
            print(i, Thread.current)
        }
        completion()
    }
    
    private func secondFunction(completion: @escaping() -> Void) {
        
        for i in 1...5 {
            sleep(1)
            print(i + 100, Thread.current)
        }
        completion()
    }
    
    func doFunctionWork() {
        
        DispatchQueue.global(qos: .background).async {
            
            self.firstFunction {
                self.secondFunction {
                    DispatchQueue.main.async {
                        print("All tasks completed")
                    }
                }
            }
        }
    }
    
    func performWithDispatchGroup() {
        let queue = DispatchQueue.global(qos: .background)
        let taskGroup = DispatchGroup()
        
        taskGroup.enter()
        queue.async {
            self.firstFunction {
                taskGroup.leave()
            }
        }
        
        taskGroup.notify(queue: queue) {
            taskGroup.enter()
            
            self.secondFunction {
                taskGroup.leave()
            }
            
            taskGroup.notify(queue: .main) {
                print("All task completed")
            }
        }
        
    }
}

extension DispatchGroupImplementation {
    
    func example1() {
        
        var processingData: [Int] = Array(repeating: 2, count: 10)
        let dispatchGroup = DispatchGroup()
        
        for indx in 0..<10 {
            dispatchGroup.enter()
            
            someAsynchronousTask { data, error in
                
                defer { dispatchGroup.leave() }
                
//                guard let data = data,
//                      error == nil else {
//                          return
//                      }
                
                DispatchQueue.main.sync {
                    processingData[indx] = indx
                }
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            // update UI
        }
    }
    
    func someAsynchronousTask(completion: @escaping(Data?, Error?) -> Void) {
        sleep(10)
        completion(nil, nil)
    }
}

extension DispatchGroupImplementation {
    
    private func performAsyncTaskIntoConcurrentQueue(with completion: @escaping () -> ()) {
        
        let concurentQueue = DispatchQueue(label: "com.queue.concurrent", attributes: .concurrent)
        
        concurentQueue.async {
            for i in 1...5 {
                if Thread.isMainThread {
                    print("\(i) task running in main thread")
                } else {
                    print("\(i) task running in other thread")
                }
                
                concurentQueue.async {
                    let imageUrl = URL(string: "https://upload.wikimedia.org/wikipedia/commons/0/07/Huge_ball_at_Vilnius_center.jpg")
                    let _ = try! Data(contentsOf: imageUrl!)
                    print("\(i) finished downloading")
                }
                
                DispatchQueue.main.async {
                    completion()
                }
            }
        }
    }
    
    func example2() {
        self.performAsyncTaskIntoConcurrentQueue {
            print("All the imagea are downloaded")
        }
    }
}

extension DispatchGroupImplementation {
    
    private func performAsyncTaskInConcurrentQueue(with completion: @escaping () -> ()) {
        let concurrentQueue = DispatchQueue(label: "com.queue.Concurrent", attributes: .concurrent)
        let group = DispatchGroup()
        
        for _ in 1...5 {
            group.enter()
            concurrentQueue.async {
                let imageUrl = URL(string: "https://upload.wikimedia.org/wikipedia/commons/0/07/Huge_ball_at_Vilnius_center.jpg")
                let _ = try! Data(contentsOf: imageUrl!)
                group.leave()
            }
        }
        group.notify(queue: .main) {
            completion()
        }
    }
    
    func example3() {
        self.performAsyncTaskInConcurrentQueue {
            print("Dispatch group all the images are downloadd")
        }
    }
}
