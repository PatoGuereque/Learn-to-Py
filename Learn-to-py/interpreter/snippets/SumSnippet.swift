//
//  SummatorySnippet.swift
//  Learn-to-py
//
//  Created by Oscar Rodriguez on 25/05/21.
//

import UIKit

class SumSnippet: CodeSnippet {

    func preLoopInit(variables: inout [Variable]) {
        variables.append(Variable(name: "suma", value: "0", type: Int.self))
    }
    
    func loopLogic(steps: inout [Step], variables: inout [Variable], number: Int) {
        let last = steps[steps.count - 1]
        variables[2].value = variables[2].value! as! Int + number
        steps.append(Step(log: last.log, variables: variables, line: 1))
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
        // line -> suma += i
        let line = NSMutableAttributedString(string: "    suma += ", attributes: CodeColor.syntax)
        line.append(NSAttributedString(string: iterator.name, attributes: CodeColor.iteratorVariable))
        return [line]
    }
    
    func postLoopCode(iterator: Variable, iterable: Variable) -> [NSAttributedString] {
        return [NSMutableAttributedString(string: "print(suma)", attributes: CodeColor.syntax)]
    }
    
    func getName() -> String {
        return "sumatoria"
    }
    
}

