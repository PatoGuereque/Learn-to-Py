//
//  popUpEditarIterable.swift
//  Learn-to-py
//
//  Created by user189355 on 4/20/21.
//

import UIKit

class EditIterable: KeyboardViewPushController, UITextFieldDelegate {
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var type: UISegmentedControl!
    @IBOutlet weak var content: UITextField!
    var initialValue: String!
    var segments: [String] = []
    var delegate: AutoUpdate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = initialValue
        name.text = initialValue
        name.delegate = self
        
        type.removeAllSegments()
        
        for segment in segments {
            type.insertSegment(withTitle: segment, at: type.numberOfSegments, animated: false)
        }
        
        type.selectedSegmentIndex = 0 // Set default selection
    }
    
    // MARK: - UITextFieldDelegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return range.location < variableNameMaxLength
    }
    
    @IBAction func onExit(_ sender: UITapGestureRecognizer) {
        var shouldRefresh = false
        if let name = name.text {
            delegate.updateIterable(name: name)
            shouldRefresh = true
        }
        
        if let content = content.text {
            var array = content.components(separatedBy: " ").compactMap({ Int($0) })
            var displayFormat = "[\(array.map{String($0)}.joined(separator: ", "))]"
            
            var step = 1, min = 0, max = array.count
            if type.selectedSegmentIndex == 1 && array.count < 4 { // as range
                if array.count == 1 {
                    min = 0
                    max = array[0]
                } else if array.count == 2 {
                    min = array[0]
                    max = array[1]
                } else if array.count == 3 {
                    min = array[0]
                    max = array[1]
                    step = array[2]
                }
                
                if step != 0 {
                    displayFormat = "range(\(min), \(max), \(step))"
                    array = Array(stride(from: min, to: max, by: step))
                } else {
                    array = []
                }
            }
            
            if array.count > 0 {
                delegate.update(type: type.selectedSegmentIndex, displayFormat: displayFormat, content: array)
                shouldRefresh = true
            } else if content.count > 0 {
                let alerta = UIAlertController(title: "Error!", message: "Por favor ingrese un iterable válido", preferredStyle: .alert)
                let accion = UIAlertAction(title: "Entendido", style: .cancel, handler: nil)
                alerta.addAction(accion)
                present(alerta, animated: true, completion: nil)
                shouldRefresh = false
            }
        }
        
        if shouldRefresh {
            dismiss(animated: true, completion: nil)
            delegate.refresh()
        }
    }
    
    override func getMoveAmount(keyboardSize: CGRect) -> CGFloat {
        let maxY = self.view.superview!.frame.height - keyboardSize.height
        let contentY = content.superview!.convert(content.frame.origin, to: nil).y + content.frame.height + 20
        
        if (contentY > maxY) {
            return contentY - maxY
        }
        return 0
    }
}
