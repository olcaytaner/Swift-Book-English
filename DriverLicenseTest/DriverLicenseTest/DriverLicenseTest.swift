//
//  ViewController.swift
//  DriverLicenseTest
//
//  Created by Olcay Taner Yıldız on 11/10/2016.
//  Copyright © 2016 Olcay Taner Yıldız. All rights reserved.
//

import UIKit

class DriverLicenseTest: UIViewController {

    @IBOutlet weak var question: UITextView!
    @IBOutlet weak var choice1: UIButton!
    @IBOutlet weak var choice2: UIButton!
    @IBOutlet weak var choice3: UIButton!
    @IBOutlet weak var choice4: UIButton!
    
    var preferences : Preferences?
    var subjects : Subjects?
    var trafficNumberOfQuestions : Int = 10
    var engineNumberOfQuestions : Int = 10
    var firstAidNumberOfQuestions : Int = 10
    var numberOfCorrectAnswers : Int = 0
    var questionNo : Int = 0
    var correctAnswer : Int = 0
    var questions : [Question] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        question.isEditable = false
        readQuestionsFromFile()
        readPreferences()
        startExam()
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    func readPreferences(){
        let basicPreferencesList : NSDictionary = NSDictionary(contentsOfFile: Bundle.main.path(forResource: "BasicPreferences", ofType: "plist")!)!
        UserDefaults.standard.register(defaults: basicPreferencesList as! [String : AnyObject])
        let basicPreferences = UserDefaults.standard
        preferences = Preferences(traffic: basicPreferences.bool(forKey: "traffic"), engine: basicPreferences.bool(forKey: "engine"), firstAid: basicPreferences.bool(forKey: "firstAid"), trafficNumberOfQuestions: basicPreferences.integer(forKey: "trafficNumberOfQuestions"), engineNumberOfQuestions: basicPreferences.integer(forKey: "engineNumberOfQuestions"), firstAidNumberOfQuestions: basicPreferences.integer(forKey: "firstAidNumberOfQuestions"))
    }
    
    func readQuestionsFromFile(){
        var fileName, fileContents : String
        var lines, questionContent : [String]
        var newQuestion : Question
        fileName = Bundle.main.path(forResource: "driverlicense", ofType: "txt")!
        do{
            fileContents = try String(contentsOfFile:fileName, encoding:String.Encoding.utf16)
        }
        catch{
            fileContents = ""
        }
        lines = fileContents.components(separatedBy: "\n")
        questions = []
        for question in lines{
            questionContent = question.components(separatedBy: ";")
            if (questionContent[0] == "T" || questionContent[0] == "M" || questionContent[0] == "Y"){
                if (questionContent[6] == "A" || questionContent[6] == "B" || questionContent[6] == "C" || questionContent[6] == "D"){
                    newQuestion = Question(questionType:questionContent[0], question:questionContent[1], choice1:questionContent[2], choice2:questionContent[3], choice3:questionContent[4], choice4:questionContent[5], correctAnswer:questionContent[6])
                    questions.append(newQuestion)
                }
            }
        }
    }
    
    func getCurrentQuestion()->Question?{
        var whichQuestion, i : Int
        var questionType : String
        if (questionNo < trafficNumberOfQuestions){
            whichQuestion = questionNo
            questionType = "T"
        } else {
            if (questionNo < trafficNumberOfQuestions + engineNumberOfQuestions){
                whichQuestion = questionNo - trafficNumberOfQuestions
                questionType = "M"
            } else {
                whichQuestion = questionNo - trafficNumberOfQuestions - engineNumberOfQuestions
                questionType = "Y"
            }
        }
        i = 0
        for question in questions{
            if (question.questionType == questionType){
                if (i == whichQuestion){
                    return question
                } else {
                    i += 1
                }
            }
        }
        return nil
    }
    
    func mixQuestions(){
        var remained, changed : Int
        var tmpQuestion : Question
        for i in 0..<questions.count{
            remained = questions.count - i
            changed = i + Int(arc4random_uniform(UInt32(remained)))
            tmpQuestion = questions[i]
            questions[i] = questions[changed]
            questions[changed] = tmpQuestion
        }
    }
    
    func showCurrentQuestion(){
        var questionNoText : String
        if let currentQuestion = getCurrentQuestion(){
            questionNoText = String(format: "%d) ", questionNo + 1)
            question.text = questionNoText + currentQuestion.question
            choice1.setTitle("A) " + currentQuestion.choice1, for: UIControlState())
            choice2.setTitle("B) " + currentQuestion.choice2, for: UIControlState())
            choice3.setTitle("C) " + currentQuestion.choice3, for: UIControlState())
            choice4.setTitle("D) " + currentQuestion.choice4, for: UIControlState())
            if (currentQuestion.correctAnswer == "A"){
                correctAnswer = 1
            } else {
                if (currentQuestion.correctAnswer == "B"){
                    correctAnswer = 2
                } else {
                    if (currentQuestion.correctAnswer == "C"){
                        correctAnswer = 3
                    } else {
                        correctAnswer = 4
                    }
                }
            }
        }
    }
    
    func startExam(){
        if let _preferences = preferences{
            if (!_preferences.traffic){
                trafficNumberOfQuestions = 0
            }else{
                trafficNumberOfQuestions = _preferences.trafficNumberOfQuestions
            }
            if (!_preferences.engine){
                engineNumberOfQuestions = 0
            }else{
                engineNumberOfQuestions = _preferences.engineNumberOfQuestions
            }
            if (!_preferences.firstAid){
                firstAidNumberOfQuestions = 0
            }else{
                firstAidNumberOfQuestions = _preferences.firstAidNumberOfQuestions
            }
        }
        questionNo = 0
        numberOfCorrectAnswers = 0
        mixQuestions()
        showCurrentQuestion()
        choice1.isEnabled = true
        choice2.isEnabled = true
        choice3.isEnabled = true
        choice4.isEnabled = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        var subjects : Subjects
        if (segue.identifier == "options"){
            subjects = segue.destination as! Subjects
            subjects.preferences = preferences
        }
    }
    
    @IBAction func unwindToDriverLicenseTest(_ unwindSegue: UIStoryboardSegue){
        if (unwindSegue.identifier == "restartExam"){
            readPreferences()
            startExam()
        }
    }
    
    @IBAction func restartExamClick(_ sender: UIButton) {
        startExam()
    }
    
    @IBAction func choiceClick(_ sender: UIButton) {
        var message : String
        if (sender.tag == correctAnswer){
            numberOfCorrectAnswers += 1
        }
        questionNo += 1
        if (questionNo < trafficNumberOfQuestions + engineNumberOfQuestions + firstAidNumberOfQuestions){
            showCurrentQuestion()
        } else {
            message = String(format:"You answered %d questions correct!", numberOfCorrectAnswers)
            let alarm = UIAlertController(title: "DriverLicenseTest", message: message, preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
            alarm.addAction(okAction)
            self.present(alarm, animated: true, completion: nil)
            choice1.isEnabled = false
            choice2.isEnabled = false
            choice3.isEnabled = false
            choice4.isEnabled = false
        }
    }
}

