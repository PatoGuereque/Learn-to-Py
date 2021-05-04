//
//  ForLoopSnippet.swift
//  Learn-to-py
//
//  Created by Pato on 04/05/21.
//

import UIKit

class IfElseSnippet: CodeSnippet {
    
    func doLogic(steps: inout [Step], variables: [Variable], number: Int) {
        let last = steps[steps.count - 1]
        steps.append(Step(log: last.log, variables: variables, line: 1))
        if number % 2 == 0 {
            steps.append(Step(log: last.log + "\(number) es par\n", variables: variables, line: 2))
        } else {
            steps.append(Step(log: last.log, variables: variables, line: 3))
            steps.append(Step(log: last.log + "\(number) es impar\n", variables: variables, line: 4))
        }
    }
    
    func getName() -> String {
        return "if-else"
    }

}
