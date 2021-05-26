//
//  SumBelowTenSnippet.swift
//  Learn-to-py
//
//  Created by Oscar Rodriguez on 26/05/21.
//

import UIKit

class SumBelowTenSnippet: CodeSnippet {

    func preLoopInit(variables: inout [Variable]) {
        variables.append(Variable(name: "suma", value: "0", type: Int.self))
    }
    
    func loopLogic(steps: inout [Step], variables: inout [Variable], number: Int) {
        let last = steps[steps.count - 1]
        
        steps.append(Step(log: last.log, variables: variables, line: 1))
        
        if number < 10 {
            variables[2].value = variables[2].value! as! Int + number
            steps.append(Step(log: last.log, variables: variables, line: 2))
        }
    }
    
    func postLoopLogic(steps: inout [Step], variables: [Variable]) {
        let last = steps[steps.count - 1]
        let lastSum = variables[2].value!
        steps.append(Step(log: last.log + "\(lastSum)\n", variables: variables, line: -10)) // -10 = last line
    }
    
    func preLoopCode(iterator: Variable, iterable: Variable) -> [NSAttributedString] {
        return [NSMutableAttributedString(string: "suma = 0", attributes: CodeColor.syntax)]
    }
    
    func loopCode(iterator: Variable, iterable: Variable) -> [NSAttributedString] {
        // line -> if i < 10:
        let line1 = NSMutableAttributedString(string: "    if ", attributes: CodeColor.syntax)
        line1.append(NSAttributedString(string: iterator.name, attributes: CodeColor.iteratorVariable))
        line1.append(NSAttributedString(string: " < 10:", attributes: CodeColor.syntax))
        
        // line -> suma += i
        let line2 = NSMutableAttributedString(string: "        suma += ", attributes: CodeColor.syntax)
        line2.append(NSAttributedString(string: iterator.name, attributes: CodeColor.iteratorVariable))
        
        return [line1, line2]
    }
    
    func postLoopCode(iterator: Variable, iterable: Variable) -> [NSAttributedString] {
        return [NSMutableAttributedString(string: "print(suma)", attributes: CodeColor.syntax)]
    }
    
    func getName() -> String {
        return "suma menores a 10"
    }
    
}

