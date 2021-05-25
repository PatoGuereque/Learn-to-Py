//
//  PrintSnippet.swift
//  Learn-to-py
//
//  Created by Pato on 04/05/21.
//

import UIKit

class PrintSnippet: CodeSnippet {

    func doLogic(steps: inout [Step], variables: [Variable], number: Int) {
        let last = steps[steps.count - 1]
        steps.append(Step(log: last.log + "\(number)\n", variables: variables, line: 1))
    }
    
    func generateCode(iterator: Variable, iterable: Variable) -> [NSAttributedString] {
        // line 1 = for i in range:
        let line1 = NSMutableAttributedString(string: "for ", attributes: CodeColor.syntax)
        line1.append(NSAttributedString(string: iterator.name, attributes: CodeColor.iteratorVariable))
        line1.append(NSAttributedString(string: " in ", attributes: CodeColor.syntax))
        line1.append(NSAttributedString(string: "\(iterable.name!):", attributes: CodeColor.variable))
        
        // line 2 = print(f'{i}')
        let line2 = NSMutableAttributedString(string: "    print(f'{", attributes: CodeColor.syntax)
        line2.append(NSAttributedString(string: iterator.name, attributes: CodeColor.iteratorVariable))
        line2.append(NSAttributedString(string: "}')", attributes: CodeColor.syntax))
        
        return [
            line1,
            line2
        ]
    }
    
    func getName() -> String {
        return "print"
    }
    
}
