//
//  DifferenceExample.swift
//  StructDiffClass
//
//  Created by Laxmi Ganesh on 28/04/22.
//

import Foundation
import UIKit


class Book {
    private var pages = [Page]()
    
    func add(_ page: Page) {
        pages.append(page)
    }
}

// A memory leak occurs when a content remains in memory even after its life cycle has ended.
class Page {
    private var book: Book
    
    required init(book: Book) {
        self.book = book
    }
}


struct Element {
    var name: String
    var number: Int
}

class ClassElement {
    var name: String
    var number: Int
    
    required init(name: String, number: Int) {
        self.name = name
        self.number = number
    }
}

extension ClassElement: CustomStringConvertible {
    var description: String {
        return "Element(name: \(name), number: \(number))"
    }
}



struct CheckDiffernece {
    
    func structObjectAssigning() {
        let firstElement = Element(name: "A", number: 1)
        
        var secondElement = firstElement
        secondElement.name = "B"
        secondElement.number = 2
        
        print(firstElement)
        print(secondElement)
    }
    
    func classObjectAssigning() {
        let firstElement = ClassElement(name: "A", number: 1)
        
        let secondElement = firstElement
        secondElement.name = "B"
        secondElement.number = 2
        
        print(firstElement)
        print(secondElement)
    }
    
}

/**
 Struct output
  Element(name: "A", number: 1)
  Element(name: "B", number:2)
 
 class output
  Element(name: "B", number:2)
  Element(name: "B", number:2)
 */
