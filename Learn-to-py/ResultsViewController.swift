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
    var results: [ExamResult] = []
    let url = pathURL(name: "Rank", format: "plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadHistory()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        let result = results[indexPath.row]
        
        cell.textLabel?.text = "\(result.correctAnswers!) de \(result.questions!) correctas: \(result.grade!). \(result.date!)"
        
        return cell
    }
    
    @IBAction func regresarView(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func loadHistory() {
        do {
            if FileManager.default.fileExists(atPath: url.path) {
                let data = try Data.init(contentsOf: url)
                results = try PropertyListDecoder().decode([ExamResult].self, from: data)
                table.reloadData()
            }
        } catch {
            print(error)
        }
    }
}
