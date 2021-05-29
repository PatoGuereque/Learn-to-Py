//
//  KeyboardHiderController.swift
//  Learn-to-py
//
//  Created by Pato on 27/05/21.
//

import UIKit

class KeyboardViewPushController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                moveView(offset: getMoveAmount(keyboardSize: keyboardSize))
            }
        }
    }
    
    func moveView(offset: CGFloat) {
        self.view.frame.origin.y = 0 - offset
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    func getMoveAmount(keyboardSize: CGRect) -> CGFloat {
        return keyboardSize.height
    }
}
