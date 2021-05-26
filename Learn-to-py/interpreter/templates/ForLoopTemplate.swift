//
//  ForLoopTemplate.swift
//  Learn-to-py
//
//  Created by Pato on 25/05/21.
//

import Foundation

class ForLoopTemplate: CodeTemplate {
    
    func generateSteps(variablesOriginal: inout [Variable], snippet: CodeSnippet) -> [Step] {
        var steps: [Step] = []
        snippet.preLoopInit(variables: &variablesOriginal)
        variablesOriginal.append(Variable(name: "counter", value: "0", type: Int.self))
        var variables: [Variable] = copyVariables(variables: variablesOriginal)
        steps.append(Step(log: "", variables: variables, line: 0))
                
        if let range = variables[1].value as? Array<Int> {
            for i in range {
                variables = copyVariables(variables: variables)
                variables[0].value = i // set i (our iterator) to current index
                
                steps.append(Step(log: steps[steps.count - 1].log, variables: variables, line: 0))
                variables = copyVariables(variables: variables)
                snippet.loopLogic(steps: &steps, variables: &variables, number: i)
            }
            
            snippet.postLoopLogic(steps: &steps, variables: variables)
        }
        
        return steps
    }
    
    func loopCode(variables: [Variable]) -> [NSAttributedString] {
        let line1 = NSMutableAttributedString(string: "for ", attributes: CodeColor.syntax)
        line1.append(NSAttributedString(string: variables[0].name!, attributes: CodeColor.iteratorVariable))
        line1.append(NSAttributedString(string: " in ", attributes: CodeColor.syntax))
        line1.append(NSAttributedString(string: "\(variables[1].name!):", attributes: CodeColor.variable))
        return [line1]
    }
}
