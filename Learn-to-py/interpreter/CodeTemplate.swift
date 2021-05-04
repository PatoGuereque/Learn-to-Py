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
                let iteratorCopy = iterator.copy()
                iteratorCopy.value = i
                steps.append(Step(log: steps.count == 0 ? "" : steps[steps.count - 1].log, variables: [iteratorCopy, iterable], line: 0))
                snippet.doLogic(steps: &steps, variables: [iteratorCopy, iterable], number: i)
            }
        }
        
        return steps
    }
}
