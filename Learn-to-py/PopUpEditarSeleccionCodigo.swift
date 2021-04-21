//
//  popUpEditarSeleccionCodigo.swift
//  Learn-to-py
//
//  Created by user189355 on 4/20/21.
//

import UIKit

class PopUpEditarSeleccionCodigo: UIViewController {

    @IBOutlet weak var selectCod: UIButton!
    @IBOutlet var opcionSeleccionada: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        opcionSeleccionada.forEach{(btn) in
            btn.isHidden = true
            btn.alpha = 0
        }
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

    @IBAction func guardarSeleccionCodigo(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func selectCodigo(_ sender: UIButton) {
        opcionSeleccionada.forEach { (btn) in
            UIView.animate(withDuration: 0.6){
                btn.isHidden = !btn.isHidden
                btn.alpha = btn.alpha == 0 ? 1 : 0
                btn.layoutIfNeeded()
            }
        }
    }
    @IBAction func opcionSleccionada(_ sender: UIButton) {
        if let btnLbl = sender.titleLabel?.text{
            print(btnLbl)
            sender.titleLabel?.text = selectCod.titleLabel?.text
            selectCod.titleLabel?.text = btnLbl
        }
    }
    
}
