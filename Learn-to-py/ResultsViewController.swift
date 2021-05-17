//
//  ResultsViewController.swift
//  Learn-to-py
//
//  Created by user189625 on 5/10/21.
//

import UIKit

class ResultsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var lbResults: UILabel!
    @IBOutlet weak var table: UITableView!
    var rank = [Ranking]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if FileManager.default.fileExists(atPath: dataFileURL().path){
            obtenerIndiceRank()
        }
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rank.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celda")!
        cell.textLabel?.text = String(rank[indexPath.row].score) + " / 3"
        return cell
    }
    
    func dataFileURL() -> URL {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let pathArchivo = documentsDirectory.appendingPathComponent("Rank").appendingPathExtension("plist")
        print(pathArchivo.path)
        return pathArchivo
    }
    
    @IBAction func regresarView(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func obtenerIndiceRank(){
        rank.removeAll()
        
        do{
            let data = try Data.init(contentsOf: dataFileURL())
            rank = try PropertyListDecoder().decode([Ranking].self, from: data)
            table.reloadData()
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
