//
//  ExamViewController.swift
//  Learn-to-py
//
//  Created by user189625 on 5/13/21.
//

import UIKit

class ExamViewController: UIViewController {

    @IBOutlet weak var lbPregunta: UILabel!
    @IBOutlet weak var tfRespuesta: UITextField!
    @IBOutlet weak var lbSolucion: UILabel!
    @IBOutlet weak var imgFoto: UIImageView!
    
    var grade = 0
    var questionList = [
        Question(content: "¿Cuánto vale i en la tercera iteración?", answer: "3", image: UIImage(named: "Ciclo for"))
    ]
   
    override func viewDidLoad() {
        super.viewDidLoad()
        tfRespuesta.inputView = UIView()
        lbPregunta.text = questionList[0].content
        imgFoto.image = questionList[0].image

        // Do any additional setup after loading the view.
    }
    /*
    func onLabelClick() {
       var guess = tfRespuesta.text
       if questionList.isCorrect(guess: guess) {
         grade+=1
       }
    }*/
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
