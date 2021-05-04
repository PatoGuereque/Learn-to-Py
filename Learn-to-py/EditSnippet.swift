//
//  popUpEditarSeleccionCodigo.swift
//  Learn-to-py
//
//  Created by user189355 on 4/20/21.
//

import UIKit

class EditSnippet: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var codeSnippets: UIPickerView!
    var delegate: AutoUpdate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.codeSnippets.delegate = self
        self.codeSnippets.dataSource = self
    }
    
    // MARK: - UIPickerView
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return codeSnippetNames.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return codeSnippetNames[row]
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func onExit(_ sender: UITapGestureRecognizer) {
        delegate.update(snippet: CodeSnippet(rawValue: codeSnippets.selectedRow(inComponent: 0))!)
        dismiss(animated: true, completion: nil)
    }
}
