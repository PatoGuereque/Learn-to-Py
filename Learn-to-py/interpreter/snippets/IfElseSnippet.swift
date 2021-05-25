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
    
    func generateCode(iterator: Variable, iterable: Variable) -> [NSAttributedString] {
        // line 1 = for i in range:
        let line1 = NSMutableAttributedString(string: "for ", attributes: CodeColor.syntax)
        line1.append(NSAttributedString(string: iterator.name, attributes: CodeColor.iteratorVariable))
        line1.append(NSAttributedString(string: " in ", attributes: CodeColor.syntax))
        line1.append(NSAttributedString(string: "\(iterable.name!):", attributes: CodeColor.variable))
        
        // line 2 = if i % 2 == 0:
        let line2 = NSMutableAttributedString(string: "    if ", attributes: CodeColor.syntax)
        line2.append(NSAttributedString(string: iterator.name, attributes: CodeColor.iteratorVariable))
        line2.append(NSAttributedString(string: " % 2 == 0:", attributes: CodeColor.syntax))
        
        // line 3 = print(f' {i} es par')
        let line3 = NSMutableAttributedString(string: "        print(f'{", attributes: CodeColor.syntax)
        line3.append(NSAttributedString(string: iterator.name, attributes: CodeColor.iteratorVariable))
        line3.append(NSAttributedString(string: "} es par')", attributes: CodeColor.syntax))
        
        // line 4 = else:
        let line4 = NSMutableAttributedString(string: "    else:", attributes: CodeColor.syntax)
        
        // line 5 = print(f' {i} es par')
        let line5 = NSMutableAttributedString(string: "        print(f'{", attributes: CodeColor.syntax)
        line5.append(NSAttributedString(string: iterator.name, attributes: CodeColor.iteratorVariable))
        line5.append(NSAttributedString(string: "} es impar')", attributes: CodeColor.syntax))
                     
        return [
            line1,
            line2,
            line3,
            line4,
            line5
        ]
    }
    
    func getName() -> String {
        return "if-else"
    }

}
