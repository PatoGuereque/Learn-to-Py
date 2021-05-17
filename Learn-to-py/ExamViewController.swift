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
    
    var indiceRank : Int!
    var grade : Int!
    var indicePregunta : Int!
    var questionList = [
        Question(content: "¿La variable i es par o impar en la tercera iteración? (Par/Impar)", answer: "Impar", image: UIImage(named: "Pregunta 1")),
        Question(content: "¿La variable i es par o impar en la cuarta iteración? (Par/Impar)", answer: "Par", image: UIImage(named: "Pregunta 2")),
        Question(content: "¿La variable i es par o impar en la primera iteración? (Par/Impar)", answer: "Par", image: UIImage(named: "Pregunta 3")),
        Question(content: "¿Qué valor tiene el paso de la variable iterable?", answer: "3", image: UIImage(named: "Pregunta 4")),
        Question(content: "¿Qué valor tiene el paso de la variable iterable?", answer: "4", image: UIImage(named: "Pregunta 5"))
    ]
    var rank = [Ranking]()
    var rankTemp : Ranking!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        let app = UIApplication.shared
        
        NotificationCenter.default.addObserver(self, selector: #selector(guardarRank), name: UIApplication.didEnterBackgroundNotification, object: app)
        
        if FileManager.default.fileExists(atPath: dataFileURL().path){
            obtenerIndiceRank()
        }
        indicePregunta = 0
        grade = 0
        tfRespuesta.inputView = UIView()
        lbPregunta.text = questionList[indicePregunta].content
        imgFoto.image = questionList[indicePregunta].image
    }
    
    @IBAction func botonValidar(_ sender: UIButton) {
        if indicePregunta < 4 {
            if indicePregunta == 3{
                rank.append(rankTemp)
            }
            if let respuestaTemporal = tfRespuesta.text {
                if respuestaTemporal == questionList[indicePregunta].answer {
                    lbSolucion.text = "Su respuesta es correcta"
                    //grade+=1
                    rankTemp.score += 1
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
    
    override func viewWillDisappear(_ animated: Bool) {
        guardarRank()
    }
    @IBAction func regresar(_ sender: UIButton) {
        guardarRank()
        self.dismiss(animated: true, completion: nil)
    }
    
    func dataFileURL() -> URL {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let pathArchivo = documentsDirectory.appendingPathComponent("Rank").appendingPathExtension("plist")
        print(pathArchivo.path)
        return pathArchivo
    }
    
    @IBAction func guardarRank(){
        do{
            let data = try PropertyListEncoder().encode(rank)
            try data.write(to: dataFileURL())
        }
        catch{
            //print("Error al guardar los datos")
        }
    }
    
    func obtenerIndiceRank(){
        rank.removeAll()
        
        do{
            let data = try Data.init(contentsOf: dataFileURL())
            rank = try PropertyListDecoder().decode([Ranking].self, from: data)
            indiceRank = rank.count
        }
        catch{
            print("Error al cargaar los datos del archivo")
        }
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
