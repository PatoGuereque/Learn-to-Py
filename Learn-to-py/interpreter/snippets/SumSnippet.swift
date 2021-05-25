//
//  SummatorySnippet.swift
//  Learn-to-py
//
//  Created by Oscar Rodriguez on 25/05/21.
//

import UIKit

class SumSnippet: CodeSnippet {

    func doLogic(steps: inout [Step], variables: [Variable], number: Int) {
        return
    }
    
    func generateCode(iterator: Variable, iterable: Variable) -> [NSAttributedString] {        
        // line 1 -> suma = 0
        let line1 = NSMutableAttributedString(string: "suma = 0", attributes: CodeColor.syntax)
        
        // line 2 -> for i in range:
        let line2 = NSMutableAttributedString(string: "for ", attributes: CodeColor.syntax)
        line2.append(NSAttributedString(string: iterator.name, attributes: CodeColor.iteratorVariable))
        line2.append(NSAttributedString(string: " in ", attributes: CodeColor.syntax))
        line2.append(NSAttributedString(string: "\(iterable.name!):", attributes: CodeColor.variable))
        
        // line 3 -> suma += i
        let line3 = NSMutableAttributedString(string: "    suma += ", attributes: CodeColor.syntax)
        line3.append(NSAttributedString(string: iterator.name, attributes: CodeColor.iteratorVariable))
        
        // line 4 -> print(suma)
        let line4 = NSMutableAttributedString(string: "print(suma)", attributes: CodeColor.syntax)
        
        return [
            line1,
            line2,
            line3,
            line4
        ]
    }
    
    func getName() -> String {
        return "sumatoria"
    }
    
}

