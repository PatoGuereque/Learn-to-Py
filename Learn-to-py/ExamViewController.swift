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
        Question(content: "¿La variable i es par o impar en la tercera iteración? (Par/Impar)", answer: "Impar", image: UIImage(named: "Pregunta 1")),
        Question(content: "¿La variable i es par o impar en la cuarta iteración? (Par/Impar)", answer: "Par", image: UIImage(named: "Pregunta 2")),
        Question(content: "¿La variable i es par o impar en la primera iteración? (Par/Impar)", answer: "Par", image: UIImage(named: "Pregunta 3")),
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
        if let guess = answer.text {
            if questions[question].isCorrect(guess: guess) {
                result.correctAnswers += 1
                status.text = "Su respuesta es correcta"
            } else {
                status.text = "Su respuesta es incorrecta"
            }
            
            question += 1
            if question == questions.count {
                registerResults()
                exit(sender)
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
