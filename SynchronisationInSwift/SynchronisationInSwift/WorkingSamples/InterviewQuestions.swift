//
//  Interview_questions.swift
//  Dispatch_operation
//
//  Created by Laxmi Ganesh on 13/04/22.
//

import Foundation

struct InterviewQuestions {
    
    func example1() {
        let queue = DispatchQueue(label: "com.swift.sample", attributes: .concurrent)
        
        queue.sync {
            Thread.sleep(forTimeInterval: 3)
            print("Task 1 done")
        }
        
        queue.sync {
            Thread.sleep(forTimeInterval: 1)
            print("Task 2 done")
        }
        /**output
           Task 1 done
           Task 2 done
        **/
    }
    
    func example2() {
        let queue = DispatchQueue(label: "com.swift.sample", attributes: .concurrent)
        
        queue.async {
            Thread.sleep(forTimeInterval: 3)
            print("Task 1 done")
        }
        
        queue.async {
            Thread.sleep(forTimeInterval: 1)
            print("Task 2 done")
        }
        
        /**output
           Task 2 done
           Task 1 done
        **/
    }
}
