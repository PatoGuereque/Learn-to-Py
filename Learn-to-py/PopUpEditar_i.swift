//
//  popUpEditar_i.swift
//  Learn-to-py
//
//  Created by user189355 on 4/20/21.
//

import UIKit

class PopUpEditar_i: UIViewController {

    @IBOutlet weak var tfNombreVar: UITextField!
    @IBOutlet weak var lb_i: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func guardarNombre(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
}
