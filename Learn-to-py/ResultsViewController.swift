//
//  ResultsViewController.swift
//  Learn-to-py
//
//  Created by user189625 on 5/10/21.
//

import UIKit

class ResultsViewController: UIViewController {

    @IBOutlet weak var lbResults: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func mostrarResultados() {
        
        let defaults = UserDefaults.standard
        if let data = defaults.value(forKey: "texto") as? String {
            lbResults.text = data
        }
    }
    
    func guardarResultados() {
        let defaults = UserDefaults.standard
        var grade = 0.6
        var results = "Calificación: \(grade) - \(Date())\n"
        defaults.setValue(results, forKey: "texto")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
