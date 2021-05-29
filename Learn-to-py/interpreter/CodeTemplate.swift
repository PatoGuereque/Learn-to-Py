//
//  CodeTemplate.swift
//  Learn-to-py
//
//  Created by Oscar Rodriguez on 18/04/21.
//

import Foundation

protocol CodeTemplate {
    var name: String { get }
    
    func generateSteps(variablesOriginal: inout [Variable], snippet: CodeSnippet) -> [Step]
    
    func loopCode(variables: [Variable]) -> [NSAttributedString]
    
    func endLoopCode() -> [NSAttributedString]
    
}

extension CodeTemplate {
    func copyVariables(variables: [Variable]) -> [Variable] {
        var copy: [Variable] = []
        for variable in variables {
            copy.append(variable.copy())
        }
        return copy
    }
    
    func endLoopCode() -> [NSAttributedString] {
        return []
    }
}
