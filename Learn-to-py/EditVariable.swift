//
//  popUpEditar_i.swift
//  Learn-to-py
//
//  Created by user189355 on 4/20/21.
//

import UIKit

class EditVariable: UIViewController {
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var label: UILabel!
    var initialValue: String!
    var delegate: AutoUpdate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        name.text = initialValue
        label.text = initialValue
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func onExit(_ sender: UITapGestureRecognizer) {
        if let name = name.text {
            delegate.update(name: name)
            dismiss(animated: true, completion: nil)
        }
    }
}
