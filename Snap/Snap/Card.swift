//
//  Kart.swift
//  Pisti
//
//  Created by Olcay Taner YILDIZ on 1/18/15.
//  Copyright (c) 2015 Olcay Taner YILDIZ. All rights reserved.
//

class Card{
    var type : String = ""
    var value : Int = 0
    
    init(type : String, value : Int){
        self.type = type
        self.value = value
    }
    
    func description()->String{
        switch (value){
            case 2, 3, 4, 5, 6, 7, 8, 9, 10:
                return type + String(format: "_%d", value)
            case 1:
                return type + "_ace"
            case 11:
                return type + "_jack"
            case 12:
                return type + "_queen"
            case 13:
                return type + "_king"
            default:
                return type
        }
    }
}
