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
    var snippet = codeSnippetsArr[0]
    var iterator = Variable(name: "i", value: "0", type: Int.self)
    var iterable = Variable(name: "iter", value: "1 2 3", type: Array<Int>.self)
    var isPlaying = false
    @IBOutlet weak var snippetText: UILabel!
    @IBOutlet weak var codeHighlight: UIView!
    @IBOutlet weak var console: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var iteratorLabel: UILabel!
    @IBOutlet weak var iterableLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refresh()
    }
    
    // Rerun steps and update labels and console.
    func refresh() {
        isPlaying = false
        playButton.setTitle("▶️", for: .normal)
        step = 0
        steps = CodeTemplate.shared.forLoop(iterator: iterator, iterable: iterable, snippet: snippet)
        var start: [NSAttributedString] = []
        UIView.animate(withDuration: 0.3) {
            self.codeHighlight.frame.origin.y = CGFloat(7)
        }
        
        updateLabels()
        
        // line 1 = for i in range:
        let line1 = NSMutableAttributedString(string: "for ", attributes: CodeColor.syntax)
        line1.append(NSAttributedString(string: iterator.name, attributes: CodeColor.iteratorVariable))
        line1.append(NSAttributedString(string: " in ", attributes: CodeColor.syntax))
        line1.append(NSAttributedString(string: "\(iterable.name!):", attributes: CodeColor.variable))
        start.append(line1)
        
        start.append(contentsOf: snippet.generateCode(iterator: iterator, iterable: iterable))
        let lines: NSAttributedString = start.joined(with: "\n")
        snippetText.attributedText = lines
        self.snippetText.sizeToFit()
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
            step = max(step - 1, 0)
        }
        moveStep()
    }
    
    func moveStep() {
        UIView.animate(withDuration: 0.3) {
            self.codeHighlight.frame.origin.y = CGFloat(7 + 18 * self.steps[self.step].line)
        }

        iterator = steps[step].variables[0]
        iterable = steps[step].variables[1]

        updateLabels()
    }
    
    func updateLabels() {
        iteratorLabel.text = "\(iterator.name!) = \(iterator.value!)"
        let iterableValue = iterable.value as! Array<Int>
        
        if iterableType == 0 {
            iterableLabel.text = "\(iterable.name!) = [\(iterableValue.map{String($0)}.joined(separator: ", "))]"
        } else {
            let step = iterableValue.count > 1 ? iterableValue[1] - iterableValue[0] : 1
            iterableLabel.text = "\(iterable.name!) = range(\(iterableValue.first!), \(iterableValue.last! + 1), \(step))"
        }
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
                view.initialValue = iterator.name
            }
            
            if button.restorationIdentifier == "iterable" {
                let view = segue.destination as! EditIterable
                view.delegate = self
                view.initialValue = iterable.name
            }
            
            if button.restorationIdentifier == "snippet" {
                let view = segue.destination as! EditSnippet
                view.delegate = self
            }
        }
    }
}
