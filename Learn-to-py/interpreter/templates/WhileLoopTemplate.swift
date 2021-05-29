//
//  WhilteLoopTemplate.swift
//  Learn-to-py
//
//  Created by Pato on 25/05/21.
//

import Foundation

class WhileLoopTemplate: CodeTemplate {
    var name: String = "while"
    
    func generateSteps(variablesOriginal: inout [Variable], snippet: CodeSnippet) -> [Step] {
        var steps: [Step] = []
        snippet.preLoopInit(variables: &variablesOriginal)
        variablesOriginal.append(Variable(name: "counter", value: "0", type: Int.self))
        var variables: [Variable] = copyVariables(variables: variablesOriginal)
        steps.append(Step(log: "", variables: variables, line: 0))
        
        let loc = snippet.loopCode(iterator: variables[0], iterable: variables[1]).count + 1
                
        if let range = variables[1].value as? Array<Int> {
            var counter = 0
            while counter < range.count {
                let i = range[counter]
                variables = copyVariables(variables: variables)
                steps.append(Step(log: steps[steps.count - 1].log, variables: variables, line: -1))
                variables = copyVariables(variables: variables)
                variables[0].value = i // set i (our iterator) to current index
                
                steps.append(Step(log: steps[steps.count - 1].log, variables: variables, line: 0))
                variables = copyVariables(variables: variables)
                snippet.loopLogic(steps: &steps, variables: &variables, number: i)
                
                variables[variables.count - 1].value = counter // set counter to current index
                variables = copyVariables(variables: variables)
                steps.append(Step(log: steps[steps.count - 1].log, variables: variables, line: loc))
                
                counter += 1
            }
            
            snippet.postLoopLogic(steps: &steps, variables: variables)
        }
        
        return steps
    }
    
    func loopCode(variables: [Variable]) -> [NSAttributedString] {        
        let line1 = NSMutableAttributedString(string: "while ", attributes: CodeColor.syntax)
        line1.append(NSAttributedString(string: "counter", attributes: CodeColor.variable))
        line1.append(NSAttributedString(string: " < ", attributes: CodeColor.syntax))
        line1.append(NSAttributedString(string: "len(\(variables[1].name!)):", attributes: CodeColor.variable))
        
        
        let line2 = NSMutableAttributedString(string: "    \(variables[0].name!) ", attributes: CodeColor.iteratorVariable)
        line2.append(NSAttributedString(string: "= ", attributes: CodeColor.syntax))
        line2.append(NSAttributedString(string: "\(variables[1].name!)", attributes: CodeColor.variable))
        line2.append(NSAttributedString(string: "[", attributes: CodeColor.syntax))
        line2.append(NSAttributedString(string: "counter", attributes: CodeColor.variable))
        line2.append(NSAttributedString(string: "]", attributes: CodeColor.syntax))
        return [line1, line2]
    }
    
    func endLoopCode() -> [NSAttributedString] {
        return [NSMutableAttributedString(string: "    counter += 1", attributes: CodeColor.syntax)]
    }
}
