//
//  ExamViewController.swift
//  Learn-to-py
//
//  Created by user189625 on 5/13/21.
//

import UIKit

class ExamViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var answer: UITextField!
    @IBOutlet weak var status: UILabel!
    
    var result: ExamResult!
    var question: Int!
    var questions = [
        Question(content: "¿La variable i es par o impar en la tercera iteración? (par/impar)", answer: "impar", image: UIImage(named: "Pregunta 1")),
        Question(content: "¿La variable i es par o impar en la cuarta iteración? (par/impar)", answer: "par", image: UIImage(named: "Pregunta 2")),
        Question(content: "¿La variable i es par o impar en la primera iteración? (par/impar)", answer: "par", image: UIImage(named: "Pregunta 3")),
        Question(content: "¿Qué valor tiene el paso de la variable iterable?", answer: "3", image: UIImage(named: "Pregunta 4")),
        Question(content: "¿Qué valor tiene el paso de la variable iterable?", answer: "4", image: UIImage(named: "Pregunta 5"))
    ]
    let url = pathURL(name: "Rank", format: "plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        question = 0
        result = ExamResult(questions: Double(questions.count))
        questionLabel.text = questions[question].content
        image.image = questions[question].image
    }
    
    @IBAction func checkQuestion(_ sender: UIButton) {
        let textoIngresado = answer.text?.lowercased()
        if let guess = textoIngresado {
            if questions[question].isCorrect(guess: guess) {
                result.correctAnswers += 1
                status.text = "Su respuesta es correcta"
            } else {
                status.text = "Su respuesta es incorrecta"
            }
            
            question += 1
            if question == questions.count {
                result.date = Date()
                let alerta = UIAlertController(title: "Resultados", message: "Su calificación en este examen es de \(result.grade!)", preferredStyle: .alert)
                let accion = UIAlertAction(title: "Entendido", style: .cancel, handler: { action in
                    self.registerResults()
                    self.exit(sender)
                })
                alerta.addAction(accion)
                present(alerta, animated: true, completion: nil)
            } else {
                questionLabel.text = questions[question].content
                image.image = questions[question].image
            }
        }
    }
    
    func registerResults() {
        var history: [ExamResult] = []
        
        // attempt to load history if it's not corrupt
        do {
            if FileManager.default.fileExists(atPath: url.path) {
                let contents = try Data.init(contentsOf: url)
                history = try PropertyListDecoder().decode([ExamResult].self, from: contents)
            }
        } catch { }
        
        // insert and save data
        history.insert(result!, at: 0)
        do {
            let data = try PropertyListEncoder().encode(history)
            try data.write(to: url)
        } catch {
            print(error)
        }
    }
    
    // MARK: - Tap Gesture Recognizer
    @IBAction func onViewTap(_ sender: UITapGestureRecognizer) {
        hideKeyboard()
    }
    
    // MARK: - Navigation
    @IBAction func exit(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
