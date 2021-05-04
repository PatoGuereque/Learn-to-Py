//
//  popUpEditarIterable.swift
//  Learn-to-py
//
//  Created by user189355 on 4/20/21.
//

import UIKit

class EditIterable: UIViewController {
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var type: UISegmentedControl!
    @IBOutlet weak var content: UITextField!
    var delegate: AutoUpdate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
            
            delegate.update(name: name, type: type.selectedSegmentIndex, content: array)
            dismiss(animated: true, completion: nil)
        }
    }
}
