//
//  Step.swift
//  Learn-to-py
//
//  Created by Oscar Rodriguez on 18/04/21.
//

import Foundation

class Step {
    let log: String!
    let variables: [Variable]!
    let line: Int!
    
    init(log: String!, variables: [Variable]!, line: Int!) {
        self.log = log
        self.variables = variables
        self.line = line
    }
}
