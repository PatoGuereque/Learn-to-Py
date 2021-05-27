//
//  popUpEditar_i.swift
//  Learn-to-py
//
//  Created by user189355 on 4/20/21.
//

import UIKit

class EditVariable: KeyboardViewPushController, UITextFieldDelegate {
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var label: UILabel!
    var initialValue: String!
    var delegate: AutoUpdate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        name.text = initialValue
        label.text = initialValue
        name.delegate = self
    }

    // MARK: - UITextFieldDelegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return range.location < variableNameMaxLength
    }

    @IBAction func onExit(_ sender: UITapGestureRecognizer) {
        if let name = name.text {
            delegate.update(name: name)
            dismiss(animated: true, completion: nil)
        }
    }
    
    override func getMoveAmount(keyboardSize: CGRect) -> CGFloat {
        let maxY = self.view.superview!.frame.height - keyboardSize.height
        let nameY = name.superview!.convert(name.frame.origin, to: nil).y + name.frame.height + 20
        
        if (nameY > maxY) {
            return nameY - maxY
        }
        return 0
    }
}
