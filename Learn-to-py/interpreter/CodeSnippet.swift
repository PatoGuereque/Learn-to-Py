//
//  CodeSnippet.swift
//  Learn-to-py
//
//  Created by Pato on 04/05/21.
//

import UIKit

protocol CodeSnippet {
    
    func doLogic(steps: inout [Step], variables: [Variable], number: Int)
    
    func getName() -> String
    
}
