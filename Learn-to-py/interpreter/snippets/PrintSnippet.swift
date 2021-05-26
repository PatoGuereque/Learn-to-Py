//
//  PrintSnippet.swift
//  Learn-to-py
//
//  Created by Pato on 04/05/21.
//

import UIKit

class PrintSnippet: CodeSnippet {

    func loopLogic(steps: inout [Step], variables: inout [Variable], number: Int) {
        let last = steps[steps.count - 1]
        steps.append(Step(log: last.log + "\(number)\n", variables: variables, line: 1))
    }
    
    func loopCode(iterator: Variable, iterable: Variable) -> [NSAttributedString] {
        // line 1 = print(f'{i}')
        let line1 = NSMutableAttributedString(string: "    print(", attributes: CodeColor.syntax)
        line1.append(NSAttributedString(string: iterator.name, attributes: CodeColor.iteratorVariable))
        line1.append(NSAttributedString(string: ")", attributes: CodeColor.syntax))
        
        return [line1]
    }
    
    func getName() -> String {
        return "print"
    }
    
}
