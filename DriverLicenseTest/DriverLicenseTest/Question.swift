//
//  Soru.swift
//  EhliyetSinavi
//
//  Created by Olcay Taner YILDIZ on 1/11/15.
//  Copyright (c) 2015 Olcay Taner YILDIZ. All rights reserved.
//

class Question{
    var questionType : String = ""
    var question : String = ""
    var choice1 : String = ""
    var choice2 : String = ""
    var choice3 : String = ""
    var choice4 : String = ""
    var correctAnswer : String = ""
    
    init(questionType:String, question:String, choice1:String, choice2:String, choice3:String, choice4:String, correctAnswer:String){
        self.questionType = questionType
        self.question = question
        self.choice1 = choice1
        self.choice2 = choice2
        self.choice3 = choice3
        self.choice4 = choice4
        self.correctAnswer = correctAnswer
    }
}
