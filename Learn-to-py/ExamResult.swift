//
//  ExamResult.swift
//  Learn-to-py
//
//  Created by user189355 on 5/16/21.
//

import UIKit

class ExamResult: NSObject, Codable {
    var questions: Double!
    var correctAnswers: Double!
    var grade: Double! { (correctAnswers / questions) * 100 }
    var date: Date!

    init(questions: Double!) {
        self.questions = questions
        self.correctAnswers = 0
    }
}
