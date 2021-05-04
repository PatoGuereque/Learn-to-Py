//
//  Variable.swift
//  Learn-to-py
//
//  Created by Oscar Rodriguez on 18/04/21.
//

import Foundation

protocol Copiable {
    init(instance: Self)
}

extension Copiable { // Make a copy of the object to avoid pass-by-reference
    func copy() -> Self {
        return Self.init(instance: self)
    }
}

class Variable: Copiable {
    var name: String!
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
    
    required init(instance: Variable) {
        self.name = instance.name
        self.value = instance.value
    }
}
