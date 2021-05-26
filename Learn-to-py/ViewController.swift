//
//  ViewController.swift
//  Learn-to-py
//
//  Created by Pato on 18/04/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func unwind(_ seg: UIStoryboardSegue) {
        
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.landscape
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "for" {
            let controller = segue.destination as! ViewControllerLoop
            controller.codeTemplate = ForLoopTemplate()
        } else if segue.identifier == "while" {
            let controller = segue.destination as! ViewControllerLoop
            controller.codeTemplate = WhileLoopTemplate()
        }
    }
}

