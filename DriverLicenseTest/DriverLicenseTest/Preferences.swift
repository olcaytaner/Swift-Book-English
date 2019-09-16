//
//  Tercihler.swift
//  EhliyetSinavi
//
//  Created by Olcay Taner YILDIZ on 1/11/15.
//  Copyright (c) 2015 Olcay Taner YILDIZ. All rights reserved.
//

class Preferences{
    var traffic : Bool = true
    var engine : Bool = true
    var firstAid : Bool = true
    var trafficNumberOfQuestions : Int = 10
    var engineNumberOfQuestions : Int = 10
    var firstAidNumberOfQuestions : Int = 10
    
    init(traffic : Bool, engine : Bool, firstAid : Bool, trafficNumberOfQuestions : Int, engineNumberOfQuestions : Int, firstAidNumberOfQuestions : Int){
        self.traffic = traffic
        self.engine = engine
        self.firstAid = firstAid
        self.trafficNumberOfQuestions = trafficNumberOfQuestions
        self.engineNumberOfQuestions = engineNumberOfQuestions
        self.firstAidNumberOfQuestions = firstAidNumberOfQuestions
    }
}
