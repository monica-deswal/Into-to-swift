//
//  Closures.swift
//  Closure
//
//  Created by Laxmi Ganesh on 25/04/22.
//

import Foundation

struct Closures {
    
    let noParamAndNoReturn: () -> Void = {
        print("Hello")
    }
    
    let oneParamAndOneReturn: (Int) -> Int = { (valPassed) in
        return valPassed
    }
    
    let twoParamAndOneReturn: (Int, Int) -> Int = { (value1, value2) in
        return value1 + value2
    }
    
    let twoParamAndOneStringReturn: (Int, Int) -> String = { (value1, value2) in
        return String("Sum is \(value1 + value2)")
    }
    
    func makeIncrementor(forIncrement amount: Int) -> () -> Int {
        var runningTotal = 0
        
        func increementer() -> Int {
            runningTotal += amount
            return runningTotal
        }
        return increementer
    }
    
    func callCaptureList() {
        CaptureList()
    }
}

class CaptureList: NSObject {
    
    let digit = 5
    
    override init() {
        super.init()
        
        makeSquareOfValue { [digit] squareDigit in
            print("Square of \(digit) is \(squareDigit)")
        }
    }
    
    func makeSquareOfValue(onCompletion: (Int) -> Void) {
        let squareDigit = digit + digit
        onCompletion(squareDigit)
    }
}
