//
//  Variable.swift
//  Learn-to-py
//
//  Created by Oscar Rodriguez on 18/04/21.
//

import Foundation

class Variable {
    let name: String!
    var value: Any!
    
    init<T>(name: String!, value: String!, type: T.Type) {
        self.name = name
        
        if type == Int.self {
            self.value = Int(value)
        } else if type == Array<Int>.self {
            self.value = value.components(separatedBy: " ").map({Int($0)})
        } else {
            self.value = nil
        }
    }
}
