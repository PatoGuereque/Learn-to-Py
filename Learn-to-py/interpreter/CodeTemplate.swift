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
        var variables: [Variable] = [iterator, iterable]
        snippet.preLoopInit(variables: &variables)
        steps.append(Step(log: "", variables: variables, line: 0))
                
        if let range = iterable.value as? Array<Int> {
            for i in range {
                variables = copyVariables(variables: variables)
                variables[0].value = i // set i (out iterator) to current index
                
                steps.append(Step(log: steps[steps.count - 1].log, variables: variables, line: 0))
                variables = copyVariables(variables: variables)
                snippet.loopLogic(steps: &steps, variables: &variables, number: i)
            }
            
            snippet.postLoopLogic(steps: &steps, variables: variables)
        }
        
        return steps
    }
    
    func copyVariables(variables: [Variable]) -> [Variable] {
        var copy: [Variable] = []
        for variable in variables {
            copy.append(variable.copy())
        }
        return copy
    }
}
