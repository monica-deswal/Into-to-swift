//
//  MemoryManagement.swift
//  StructDiffClass
//
//  Created by Laxmi Ganesh on 28/04/22.
//

import Foundation

struct SomeStruct {
    var someClass = SomeClass()
    var id = 1
}

class SomeClass {
    var name = "Neel"
}

class MemoryManagement {
    
    func allocaotionCheck() {
        let someStruct = SomeStruct()
        print(CFGetRetainCount(someStruct.someClass)) // prints 1
        var duplicateStruct = someStruct // Copy-On-Assignment happens here
        // duplicateStruct gets a new memory with `id` being duplicated
        // but the reference to someClass remains the same - IMPORTANT
        // all that happens with the reference type is that is reference count increases
        print(CFGetRetainCount(duplicateStruct.someClass)) // prints 2, now there are two structs referencing the same class
        duplicateStruct.someClass.name = "Random"
        duplicateStruct.id = 2
        print(someStruct.someClass.name) // prints Random since it holds the reference to the same class
        print(someStruct.id) // prints 1, since duplicateStruct was a copy of someStruct, changes to duplicateStruct will not effect it.
        print(duplicateStruct.id) // prints 2
        
        print(CFGetRetainCount(someStruct.someClass))
    }
}
