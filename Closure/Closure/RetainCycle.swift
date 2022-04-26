//
//  RetainCycle.swift
//  Closure
//
//  Created by Laxmi Ganesh on 26/04/22.
//

import UIKit

class RetainCycle: NSObject {
    
    var name: String 
    
    lazy var weakCycleExample: String = { [weak self] in
        
        guard let strongSelf = self else { return "" }
        
        return "Hello \(strongSelf.name)"
    }()
    
    lazy var unownedCycle: String = { [unowned self] in
        return "Hello \(self.name)"
    }()
    
    init(name: String) {
        self.name = name
    }
}
