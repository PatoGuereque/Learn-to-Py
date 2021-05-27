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
                let formatter = DateFormatter()
                formatter.dateFormat = "MMM d, h:mm a"
                result.date = Date()
                let dateString = formatter.string(from:result.date)
                NSLog("%@", dateString)
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
    
    @IBAction func exit(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func registerResults() {
        var history: [ExamResult] = []
        
        do {
            if FileManager.default.fileExists(atPath: url.path) {
                let contents = try Data.init(contentsOf: url)
                history = try PropertyListDecoder().decode([ExamResult].self, from: contents)
            }
            history.insert(result!, at: 0)
            let data = try PropertyListEncoder().encode(history)
            try data.write(to: url)
        } catch {
            print(error)
        }
    }
}
