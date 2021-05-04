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
    
    func generateCode() -> [NSAttributedString] {
        var lines: [NSAttributedString] = []
        lines.append(NSAttributedString(string: "   print(f' {i} ')"))
        return lines
    }
    
    func getName() -> String {
        return "print"
    }
    
}
