//
//  Codecolor.swift
//  Learn-to-py
//
//  Created by Pato on 16/05/21.
//

import UIKit

extension UIColor {
    
    static var codePurple = UIColor(named: "CodePurple")
    static var codeGreen = UIColor(named: "CodeGreen")
    static var codeBlue = UIColor(named: "CodeBlue")
    
}

class CodeColor {
    
    static var variable: [ NSAttributedString.Key: Any ] = [ .foregroundColor: UIColor.codePurple! ]
    static var iteratorVariable: [ NSAttributedString.Key: Any ] = [ .foregroundColor: UIColor.codeGreen! ]
    static var syntax: [ NSAttributedString.Key: Any ] = [ .foregroundColor: UIColor.codeBlue! ]
    
}
