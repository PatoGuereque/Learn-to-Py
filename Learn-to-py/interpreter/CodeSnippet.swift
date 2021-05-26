//
//  CodeSnippet.swift
//  Learn-to-py
//
//  Created by Pato on 04/05/21.
//

import UIKit

protocol CodeSnippet {
    
    func preLoopInit(variables: inout [Variable])
    func loopLogic(steps: inout [Step], variables: inout [Variable], number: Int)
    func postLoopLogic(steps: inout [Step], variables: [Variable])
    
    func preLoopCode(iterator: Variable, iterable: Variable) -> [NSAttributedString]
    func loopCode(iterator: Variable, iterable: Variable) -> [NSAttributedString]
    func postLoopCode(iterator: Variable, iterable: Variable) -> [NSAttributedString]
    
    func getName() -> String
    
}

extension CodeSnippet {
    
    func preLoopInit(variables: inout [Variable]) {
        // nothing
    }
    
    func postLoopLogic(steps: inout [Step], variables: [Variable]) {
        // nothing
    }
    
    func preLoopCode(iterator: Variable, iterable: Variable) -> [NSAttributedString] {
        return []
    }
    
    func postLoopCode(iterator: Variable, iterable: Variable) -> [NSAttributedString] {
        return []
    }
    
}
