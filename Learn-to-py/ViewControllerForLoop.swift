//
//  ViewControllerCicloFor.swift
//  Learn-to-py
//
//  Created by user189625 on 4/20/21.
//

import UIKit

protocol AutoUpdate {
    func update(name: String) // Variable update
    func update(snippet: CodeSnippet) // Snippet update
    func update(name: String, type: Int, content: Array<Int>) // Iterable update
}

class ViewControllerForLoop: UIViewController, AutoUpdate {
    var steps: [Step] = []
    var step = 0
    var iterableType = 0 // 0: array, 1: range
    var snippet = CodeSnippet.isPair
    var iterator = Variable(name: "i", value: "0", type: Int.self)
    var iterable = Variable(name: "iterable", value: "1 2 3", type: Array<Int>.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refresh()
    }
    
    // Rerun steps and update labels and console.
    func refresh() {
        step = 0
        steps = CodeTemplate.shared.forLoop(iterator: iterator, iterable: iterable, snippet: snippet)
        
        // Log steps for debugging purposes.
        for step in steps {
            print("\(step.line!) - ", terminator: "")
            for variable in step.variables {
                print("\(variable.name!): \(variable.value!), ", terminator:"")
            }

            print("\n\(step.log!)")
        }
    }
    
    @IBAction func onControlClick(_ sender: UIButton) {
        // Contains name of button being pressed.
        if sender.restorationIdentifier! == "next" {
            step = min(step + 1, steps.count - 1)
        }
        
        if sender.restorationIdentifier! == "back" {
            step = max(step - 1, 0)
        }
        
        print("\(steps[step].line!) - ", terminator: "")
        for variable in steps[step].variables {
            print("\(variable.name!): \(variable.value!), ", terminator:"")
        }

        print("\n\(steps[step].log!)")
    }
    
    // MARK: - AutoUpdate
    func update(name: String) {
        iterator.name = name
        iterator.value = 0
        
        refresh()
    }
    
    func update(snippet: CodeSnippet) {
        self.snippet = snippet

        refresh()
    }
    
    func update(name: String, type: Int, content: Array<Int>) {
        iterable.name = name
        iterable.value = content
        iterableType = type
        
        refresh()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let button = sender as? UIButton {
            if button.restorationIdentifier == "variable" {
                let view = segue.destination as! EditVariable
                view.delegate = self
            }
            
            if button.restorationIdentifier == "iterable" {
                let view = segue.destination as! EditIterable
                view.delegate = self
            }
            
            if button.restorationIdentifier == "snippet" {
                let view = segue.destination as! EditSnippet
                view.delegate = self
            }
        }
    }
}
