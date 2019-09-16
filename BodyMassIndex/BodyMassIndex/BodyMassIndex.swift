//
//  ViewController.swift
//  VucutKitleEndeksi
//
//  Created by Olcay Taner YILDIZ on 1/5/15.
//  Copyright (c) 2015 Olcay Taner YILDIZ. All rights reserved.
//

import UIKit

class BodyMassIndex: UIViewController {

    @IBOutlet weak var Situation: UILabel!
    @IBOutlet weak var BodyMassIndex: UITextField!
    @IBOutlet weak var Height: UITextField!
    @IBOutlet weak var Weight: UITextField!
    fileprivate var height: Double = 0.0
    fileprivate var weight: Double = 0.0
    fileprivate var bodyMassIndex: Double = 0.0

    override func viewDidLoad() {
        BodyMassIndex.isEnabled = false
        super.viewDidLoad()
    }
    
    @IBAction func HeightWatcher(_ sender: AnyObject) {
        if (!Height.text!.isEmpty){
            height = atof(Height.text!)
            showResult()
        }
    }
    
    @IBAction func WeightWatcher(_ sender: AnyObject) {
        if (!Weight.text!.isEmpty){
            weight = atof(Weight.text!)
            showResult()
        }
    }

    func showResult(){
        bodyMassIndex = weight / (height * height)
        if (bodyMassIndex < 20){
            Situation.text = "UnderWeight"
        } else {
            if (bodyMassIndex < 25){
                Situation.text = "Normal"
            } else {
                if (bodyMassIndex < 30){
                    Situation.text = "Overweight"
                } else {
                    if (bodyMassIndex < 35){
                        Situation.text = "Obese"
                    } else {
                        if (bodyMassIndex < 45){
                            Situation.text = "Moderately Obese"
                        } else {
                            if (bodyMassIndex < 50){
                                Situation.text = "Severly Obese"
                            } else {
                                Situation.text = "Deadly Obese"
                            }
                        }
                    }
                }
            }
        }
        BodyMassIndex.text = String(format: "%.2f", bodyMassIndex)
    }

}

