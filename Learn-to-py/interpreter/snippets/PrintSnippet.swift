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
        let line = NSMutableAttributedString(string: "        print(f'{", attributes: CodeColor.syntax)
        line.append(NSAttributedString(string: iterator.name, attributes: CodeColor.iteratorVariable))
        line.append(NSAttributedString(string: "}')", attributes: CodeColor.syntax))
        return [line]
    }
    
    func getName() -> String {
        return "print"
    }
    
}
