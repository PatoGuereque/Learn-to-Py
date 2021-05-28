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
    func update(name: String, type: Int, displayFormat: String, content: Array<Int>) // Iterable update
}

class ViewControllerLoop: UIViewController, AutoUpdate {
    var steps: [Step] = []
    var step = 1
    var iterableType = 0 // 0: array, 1: range
    var lineOffset = 0
    var linesOfCode = 0
    var snippet = codeSnippetsArr[0]
    var iterator = Variable(name: "i", value: "0", type: Int.self)
    var iterable = Variable(name: "iter", value: "1 2 3", type: Array<Int>.self)
    var isPlaying = false
    var iterableDisplayFormat: String!
    var codeTemplate: CodeTemplate!
    @IBOutlet weak var snippetText: UILabel!
    @IBOutlet weak var codeHighlight: UIView!
    @IBOutlet weak var console: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var iteratorLabel: UILabel!
    @IBOutlet weak var iterableLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var iter = ""
        let rand0 = Int.random(in: 3 ..< 5)
        
        for n in 0...rand0 - 1 {
            let rand1 = Int.random(in: 0 ..< 9)
            if n == 0 {
                iter = "\(rand1)"
            } else {
                iter = iter + " \(rand1)"
            }
        }
        
        iterable = Variable(name: "iter", value: iter, type: Array<Int>.self)
        iterableDisplayFormat = "[\((iterable.value as! Array<Int>).map{String($0)}.joined(separator: ", "))]"
        refresh()
    }
    
    // Rerun steps and update labels and console.
    func refresh() {
        isPlaying = false
        playButton.setTitle("▶️", for: .normal)
        step = 1
        lineOffset = 0
        var variables = [iterator, iterable]
        steps = codeTemplate!.generateSteps(variablesOriginal: &variables, snippet: snippet)
        
        var start: [NSAttributedString] = []
        
        let preLoopCode = snippet.preLoopCode(iterator: iterator, iterable: iterable)
        start.append(contentsOf: preLoopCode)
        lineOffset += preLoopCode.count
        
        // line 1 = for i in range:
        let codeTemplateLines = codeTemplate!.loopCode(variables: variables)
        start.append(contentsOf: codeTemplateLines)
        lineOffset += codeTemplateLines.count - 1
        
        UIView.animate(withDuration: 0.3) {
            self.codeHighlight.frame.origin.y = CGFloat(7 + 18 * (self.steps[self.step].line + self.lineOffset))
        }
        
        start.append(contentsOf: snippet.loopCode(iterator: iterator, iterable: iterable))
        start.append(contentsOf: codeTemplate.endLoopCode())
        start.append(contentsOf: snippet.postLoopCode(iterator: iterator, iterable: iterable))
        linesOfCode = start.count
        let lines: NSAttributedString = start.joined(with: "\n")
        snippetText.attributedText = lines
        
        updateLabels()
    }
    
    @IBAction func onControlClick(_ sender: UIButton) {
        if sender.restorationIdentifier! == "play" {
            if isPlaying {
                isPlaying = false
                playButton.setTitle("▶️", for: .normal)
                return
            }
            
            isPlaying = true
            playButton.setTitle("⏸︎", for: .normal)
            
            Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true) { timer in
                if !self.isPlaying {
                    timer.invalidate()
                    return
                }
                
                if self.steps.count == self.step + 1 {
                    timer.invalidate()
                    self.isPlaying = false
                    self.playButton.setTitle("▶️", for: .normal)
                    return
                }
                
                self.step = self.step + 1
                self.moveStep()
            }
            
            return
        }
        
        // Contains name of button being pressed.
        if sender.restorationIdentifier! == "next" {
            step = min(step + 1, steps.count - 1)
        }
        
        if sender.restorationIdentifier! == "back" {
            step = max(step - 1, 1)
        }
        
        if sender.restorationIdentifier! == "reset" {
            step = 1
            isPlaying = false
            playButton.setTitle("▶️", for: .normal)
        }
        
        moveStep()
    }
    
    func moveStep() {
        var line = steps[step].line + lineOffset
        if steps[step].line < -5 {
            line = linesOfCode - (steps[step].line + 11)
        }
        
        UIView.animate(withDuration: 0.3) {
            self.codeHighlight.frame.origin.y = CGFloat(7 + 18 * (line))
        }

        iterator = steps[step].variables[0]
        iterable = steps[step].variables[1]

        updateLabels()
    }
    
    func updateLabels() {
        iteratorLabel.text = "\(iterator.name!) = \(iterator.value!)"
        iterableLabel.text = "\(iterable.name!) = \(iterableDisplayFormat!)"
        console.text = steps[step].log!
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
    
    func update(name: String, type: Int, displayFormat: String, content: Array<Int>) {
        iterable.name = name
        iterable.value = content
        iterableDisplayFormat = displayFormat
        iterableType = type
        
        refresh()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let button = sender as? UIButton {
            if button.restorationIdentifier == "variable" {
                let view = segue.destination as! EditVariable
                view.delegate = self
                view.initialValue = iterator.name
            }
            
            if button.restorationIdentifier == "iterable" {
                let view = segue.destination as! EditIterable
                view.delegate = self
                view.initialValue = iterable.name
                
                if codeTemplate.name == "for" {
                    view.segments = ["arreglo", "rango"]
                } else {
                    view.segments = ["arreglo"]
                }
            }
            
            if button.restorationIdentifier == "snippet" {
                let view = segue.destination as! EditSnippet
                view.delegate = self
            }
        }
    }
}
