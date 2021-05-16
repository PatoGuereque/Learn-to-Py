//
//  Question.swift
//  Learn-to-py
//
//  Created by user189625 on 5/13/21.
//

import UIKit

class Question: NSObject {
    var content, answer : String
    var image = UIImage()

    init(content: String, answer : String, image : UIImage!){
        self.content = content
        self.answer = answer
        self.image = image
    }

    //func isCorrect(guess: String) -> bool (guess==answer){

    //}
    
}
