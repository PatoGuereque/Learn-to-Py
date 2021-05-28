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
    var delegate: AutoUpdate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = initialValue
        name.text = initialValue
        name.delegate = self
    }
    
    // MARK: - UITextFieldDelegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return range.location < variableNameMaxLength
    }
    
    @IBAction func onExit(_ sender: UITapGestureRecognizer) {
        if let name = name.text, let content = content.text {
            var array = content.components(separatedBy: " ").compactMap({ Int($0) })
            
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
                
                array = Array(stride(from: min, to: max, by: step))
            }
            
            if array.count > 0 {
                delegate.update(name: name, type: type.selectedSegmentIndex, content: array)
                dismiss(animated: true, completion: nil)
            }
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
