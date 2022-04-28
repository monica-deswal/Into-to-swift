//
//  ViewController.swift
//  StructDiffClass
//
//  Created by Laxmi Ganesh on 28/04/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        MemoryManagement().allocaotionCheck()
    }

    func classImplementation() {
        let book = Book()
        let page = Page(book: book)
        book.add(page)
        
        
    }

    
}

