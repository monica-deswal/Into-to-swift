//
//  AutoClosures.swift
//  Closure
//
//  Created by Laxmi Ganesh on 26/04/22.
//

import Foundation

struct AutoClosures {
    func Example1() {
        let person = Person(name: "Example 1 check").description
        print("Person's description is \(person)")
    }
    
    func Example2() {
        let person = PersonExample1(name: "Example 1 check")
        print({person.description})
    }
    
    func Example3AutoClosure() {
        let person = PersonAutoClosure(name: "Bernie")
        print(person.description)
    }
    
    func closureImplementation() {
        let closureImplementation = AutoClosureImplementation()
        
        print(closureImplementation.printTest1 {
            
        })
        
        print(closureImplementation.printTest1)
        
        print(closureImplementation.printTest2)
        
    }
}

struct Person: CustomStringConvertible {
    let name: String
    
    var description: String {
        print("Asking for person description")
        return "Person name is \(name)"
    }
    
    let isDebuggingEnabled: Bool = false
    
    func debugLog(_ message: String) {
        if isDebuggingEnabled {
            print("[DEBUG] \(message)")
        }
    }
}

struct PersonExample1: CustomStringConvertible {
    let name: String
    
    var description: String {
        print("Asking for person description")
        return "Person name is \(name)"
    }
    
    let isDebuggingEnabled: Bool = false
    
    func debugLog(_ message: () -> String) {
        if isDebuggingEnabled {
            print("[DEBUG] \(message())")
        }
    }
}

struct PersonAutoClosure: CustomStringConvertible {
    let name: String
    var isDebuggingEnabled: Bool = false
    
    var description: String {
        return "Person name is \(name)"
    }
    
    func debugLog(_ message: @autoclosure () -> String) {
        if isDebuggingEnabled {
            print("[DEBUG] \(message())")
        }
    }
}

struct AutoClosureImplementation {
    func printTest1(_ result: () -> Void) {
        print("Before")
        result()
        print("After")
    }
    
    func printTest2(_ result: @autoclosure () -> Void) {
        print("Before")
        result()
        print("After")
        
    }
}
