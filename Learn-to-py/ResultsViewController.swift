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
    let formatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadHistory()
        formatter.dateFormat = "MMM d, h:mm a"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        let result = results[indexPath.row]
        var dateString = ""
        
        if let date = result.date {
            dateString = formatter.string(from: date)
        }
        
        cell.textLabel?.text = "\(Int(result.correctAnswers!)) de \(Int(result.questions!)) correctas: \(result.grade!). \(dateString)"
        
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
