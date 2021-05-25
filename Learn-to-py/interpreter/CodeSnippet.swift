//
//  CodeSnippet.swift
//  Learn-to-py
//
//  Created by Pato on 04/05/21.
//

import UIKit

protocol CodeSnippet {
    
    func doLogic(steps: inout [Step], variables: [Variable], number: Int)
    
    func generateCode(iterator: Variable, iterable: Variable) -> [NSAttributedString]
    
    func getName() -> String
    
}
