//
//  ViewController.swift
//  SynchronisationInSwift
//
//  Created by Laxmi Ganesh on 20/04/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
       // basicUnderstanding()
        
     //   workItemImplementation()
        
     //   dispatchGroupImplementation()
        
      //  dispatchBarrierImplementation()
        
      //  semaphoreImplementation()
        
       // interviewQuestions()
        
        operationsImplementation()
    }

    func basicUnderstanding() {
        BasicUnderstanding().globalThread()
        BasicUnderstanding().deadlockSituation()
        BasicUnderstanding().understandingQualityOfServiceExample2()
    }
    
    func workItemImplementation() {
        DispatchWorkItemImplementation().addDispatchQueue()
        DispatchWorkItemImplementation().example1()
        DispatchWorkItemImplementation().example2()
    }
    
    func dispatchGroupImplementation() {
        DispatchGroupImplementation().example2()
        DispatchGroupImplementation().example3()
    }
    
    func dispatchBarrierImplementation() {
        DispatchBarrierImplementation().example1()
        DispatchBarrierImplementation().example2()
    }
    
    func semaphoreImplementation() {
        SemaphoreImplementation().sameExampleSemaphore()
        //RunLoop.current.run(mode: .default, before: Date(timeIntervalSinceNow: 1))
    }
    
    func interviewQuestions() {
        InterviewQuestions().example1()
        InterviewQuestions().example2()
    }
    
    func operationsImplementation() {
        OperationsImplementation().blockOperation()
        
        OperationsImplementation().blockOperationOnMainThread()
        
        OperationsImplementation().backgroundThreadBlockOperation()
        
        
        OperationsImplementation().addCompletionOperation()
    }
    
    func customOperationImplementation() {
        CustomOperationImplementation().basicOperationImplementation()
        
        
    }
}

