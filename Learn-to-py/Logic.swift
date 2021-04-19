//
//  Logic.swift
//  Learn-to-py
//
//  Created by Oscar Rodriguez on 19/04/21.
//

import Foundation

class Logic {
    static let shared = Logic()
    
    func isPair(steps: inout [Step], variables: [Variable], number: Int) {
        let last = steps[steps.count - 1]
        if number % 2 == 0 {
            steps.append(Step(log: last.log, variables: variables, line: 1))
            steps.append(Step(log: last.log + "\(number) es par\n", variables: variables, line: 2))
        } else {
            steps.append(Step(log: last.log, variables: variables, line: 3))
            steps.append(Step(log: last.log + "\(number) es impar\n", variables: variables, line: 4))
        }
    }
    
    func print(steps: inout [Step], variables: [Variable], number: Int) {
        let last = steps[steps.count - 1]
        steps.append(Step(log: last.log + "\(number)\n", variables: variables, line: 1))
    }
}
