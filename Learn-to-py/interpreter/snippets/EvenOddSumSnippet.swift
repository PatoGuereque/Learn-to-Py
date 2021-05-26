//
//  EvenOddSumSnippet.swift
//  Learn-to-py
//
//  Created by Oscar Rodriguez on 26/05/21.
//

import UIKit

class EvenOddSumSnippet: CodeSnippet {
    
    func preLoopInit(variables: inout [Variable]) {
        variables.append(Variable(name: "pares", value: "0", type: Int.self))
        variables.append(Variable(name: "impares", value: "0", type: Int.self))
    }
    
    func loopLogic(steps: inout [Step], variables: inout [Variable], number: Int) {
        let last = steps[steps.count - 1]
        
        steps.append(Step(log: last.log, variables: variables, line: 1))
        
        if number % 2 == 0 {
            variables[3].value = variables[3].value! as! Int + 1
            steps.append(Step(log: last.log, variables: variables, line: 2))
        } else {
            steps.append(Step(log: last.log, variables: variables, line: 3))
            variables[4].value = variables[4].value! as! Int + 1
            steps.append(Step(log: last.log, variables: variables, line: 4))
        }
    }
    
    func postLoopLogic(steps: inout [Step], variables: [Variable]) {
        let last = steps[steps.count - 1]
        let evens = variables[3].value!, odds = variables[4].value!
        steps.append(Step(log: last.log + "\(evens), \(odds)\n", variables: variables, line: -10)) // -10 = last line
    }
    
    func preLoopCode(iterator: Variable, iterable: Variable) -> [NSAttributedString] {
        return [NSMutableAttributedString(string: "par, imp = 0, 0", attributes: CodeColor.syntax)]
    }
    
    func loopCode(iterator: Variable, iterable: Variable) -> [NSAttributedString] {
        // line 1 = if i % 2 == 0:
        let line1 = NSMutableAttributedString(string: "    if ", attributes: CodeColor.syntax)
        line1.append(NSAttributedString(string: iterator.name, attributes: CodeColor.iteratorVariable))
        line1.append(NSAttributedString(string: " % 2 == 0:", attributes: CodeColor.syntax))
        
        // line 2 = print(f' {i} es par')
        let line2 = NSMutableAttributedString(string: "        par += ", attributes: CodeColor.syntax)
        line2.append(NSAttributedString(string: iterator.name, attributes: CodeColor.iteratorVariable))
        
        // line 3 = else:
        let line3 = NSMutableAttributedString(string: "    else:", attributes: CodeColor.syntax)
        
        // line 4 = print(f' {i} es impar')
        let line4 = NSMutableAttributedString(string: "        imp += ", attributes: CodeColor.syntax)
        line4.append(NSAttributedString(string: iterator.name, attributes: CodeColor.iteratorVariable))
        
        return [
            line1,
            line2,
            line3,
            line4
        ]
    }
    
    func postLoopCode(iterator: Variable, iterable: Variable) -> [NSAttributedString] {
        return [NSMutableAttributedString(string: "print(par, imp)", attributes: CodeColor.syntax)]
    }
    
    func getName() -> String {
        return "pares/impares"
    }

}

