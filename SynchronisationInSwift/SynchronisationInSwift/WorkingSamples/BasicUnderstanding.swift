//
//  BasicUnderstanding.swift
//  Dispatch_operation
//
//  Created by Laxmi Ganesh on 12/04/22.
//

import Foundation

struct BasicUnderstanding {
    
    // MARK: Global thread
    func globalThread() {
        
        DispatchQueue.global().sync {
           
            // this is making the app to crash
//            DispatchQueue.main.sync {
//                print("this will freeze the app")
//            }
            
            DispatchQueue.main.async {
                print("this will freeze the app")
            }
        }
        
        DispatchQueue.global().async {
            
            DispatchQueue.main.sync {
                print("Another thread gets created and after finishing reach this block ")
            }
        }
    }

    func deadlockSituation() {
        
        DispatchQueue.main.async {
            
            print("Paralled thread on main queue")
            
            // This is making the app to crash
//            DispatchQueue.main.sync {
//                
//                print("Sync operation oon the main thread")
//            }
        }
    }
    
    func understandingQualityOfServiceExample1() {
        DispatchQueue.global(qos: .background).async {
            print("performing the operation on the background thread")
            
            DispatchQueue.main.async {
                print("update the UI on the main thread")
            }
        }
    }
    
    func understandingQualityOfServiceExample2() {
        let queue = DispatchQueue(label: "com.swiftpoo")
        
        queue.async(qos: .background) {
            print("Background code")
        }
        
        queue.async(qos: .userInitiated) {
            print("User initiated code")
        }
    }
    
    
}
