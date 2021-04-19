//
//  CodeTemplate.swift
//  Learn-to-py
//
//  Created by Oscar Rodriguez on 18/04/21.
//

import Foundation

class CodeTemplate {
    static let shared = CodeTemplate()
    
    private init() {}
    
    func forLoop(iterator: Variable, iterable: Variable, snippet: CodeSnippet) -> [Step] {
        var steps: [Step] = []
        
        if let range = iterable.value as? Array<Int> {
            for i in range {
                iterator.value = i
                steps.append(Step(log: "", variables: [iterator, iterable], line: 0))
                
                switch snippet {
                case .isPair:
                    Logic.shared.isPair(steps: &steps, variables: [iterator, iterable], number: i)
                case .print:
                    Logic.shared.print(steps: &steps, variables: [iterator, iterable], number: i)
                }
            }
        }
        
        return steps
    }
}
