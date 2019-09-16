//
//  Konular.swift
//  EhliyetSinavi
//
//  Created by Olcay Taner YILDIZ on 1/11/15.
//  Copyright (c) 2015 Olcay Taner YILDIZ. All rights reserved.
//

import UIKit

class Subjects: UIViewController {

    @IBOutlet weak var trafficCounter: UILabel!
    @IBOutlet weak var engineCounter: UILabel!
    @IBOutlet weak var firstAidCounter: UILabel!
    @IBOutlet weak var trafficStepper: UIStepper!
    @IBOutlet weak var engineStepper: UIStepper!
    @IBOutlet weak var firstAidStepper: UIStepper!
    @IBOutlet weak var trafficSwitch: UISwitch!
    @IBOutlet weak var engineSwitch: UISwitch!
    @IBOutlet weak var firstAidSwitch: UISwitch!

    var preferences : Preferences?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let _preferences = preferences{
            trafficSwitch.isOn = _preferences.traffic
            engineSwitch.isOn = _preferences.engine
            firstAidSwitch.isOn = _preferences.firstAid
            trafficStepper.value = Double(_preferences.trafficNumberOfQuestions)
            engineStepper.value = Double(_preferences.engineNumberOfQuestions)
            firstAidStepper.value = Double(_preferences.firstAidNumberOfQuestions)
        }
        trafficCounter.text = String(format:"%d", Int(trafficStepper.value))
        engineCounter.text = String(format:"%d", Int(engineStepper.value))
        firstAidCounter.text = String(format:"%d", Int(firstAidStepper.value))
    }
    
    @IBAction func subjectSwitchClick(sender: UISwitch) {
        let basicPreferences = UserDefaults.standard
        switch (sender.tag){
            case 1:basicPreferences.set(trafficSwitch.isOn, forKey:"traffic")
            case 2:basicPreferences.set(engineSwitch.isOn, forKey:"engine")
            case 3:basicPreferences.set(firstAidSwitch.isOn, forKey:"firstAid")
            default:break
        }
    }
    
    @IBAction func subjectStepperClick(sender: UIStepper) {
        let basicPreferences = UserDefaults.standard
        switch (sender.tag){
            case 1:basicPreferences.set(Int(trafficStepper.value), forKey: "trafficNumberOfQuestions")
                    trafficCounter.text = String(format:"%d", Int(trafficStepper.value))
            case 2:basicPreferences.set(Int(engineStepper.value), forKey: "engineNumberOfQuestions")
                    engineCounter.text = String(format:"%d", Int(engineStepper.value))
            case 3:basicPreferences.set(Int(firstAidStepper.value), forKey: "firstAidNumberOfQuestions")
                    firstAidCounter.text = String(format:"%d", Int(firstAidStepper.value))
            default:break
        }
    }
    
}
