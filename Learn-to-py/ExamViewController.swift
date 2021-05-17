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
    
    var grade : Int!
    var indicePregunta : Int!
    var questionList = [
        Question(content: "¿La variable i es par o impar en la primera iteración? (Par/Impar)", answer: "Impar", image: UIImage(named: "Ciclo for")),
        Question(content: "¿La variable i es par o impar en la segunda iteración? (Par/Impar)", answer: "Par", image: UIImage(named: "Ciclo for")),
        Question(content: "¿La variable i es par o impar en la tercera iteración? (Par/Impar)", answer: "Impar", image: UIImage(named: "Ciclo for")),
        Question(content: "¿La variable i es par o impar en la cuarta iteración? (Par/Impar)", answer: "Par", image: UIImage(named: "Ciclo for")),
        Question(content: "¿La variable i es par o impar en la quinta iteración? (Par/Impar)", answer: "Impar", image: UIImage(named: "Ciclo for"))
    ]
   
    override func viewDidLoad() {
        super.viewDidLoad()
        indicePregunta = 0
        grade = 0
        tfRespuesta.inputView = UIView()
        lbPregunta.text = questionList[indicePregunta].content
        imgFoto.image = questionList[indicePregunta].image
    }
    
    @IBAction func botonValidar(_ sender: UIButton) {
        if indicePregunta < 4 {
            if let respuestaTemporal = tfRespuesta.text {
                if respuestaTemporal == questionList[indicePregunta].answer {
                    lbSolucion.text = "Su respuesta es correcta"
                    grade+=1
                }
                else {
                    lbSolucion.text = "Su respuesta es incorrecta"
                }
                indicePregunta+=1
                lbPregunta.text = questionList[indicePregunta].content
                imgFoto.image = questionList[indicePregunta].image
            }
        }
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
