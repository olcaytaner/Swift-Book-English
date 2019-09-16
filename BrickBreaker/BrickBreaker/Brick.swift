//
//  Tugla.swift
//  BarKirmaca
//
//  Created by Olcay Taner YILDIZ on 1/23/15.
//  Copyright (c) 2015 Olcay Taner YILDIZ. All rights reserved.
//

import UIKit

class Brick{
    var type : BrickType
    var isBroken : Bool
    var place : CGRect
    fileprivate var numberOfHits : Int
    
    init(type : BrickType, place : CGRect){
        self.type = type
        self.place = place
        isBroken = false
        numberOfHits = 0
    }
    
    func hit(){
        numberOfHits += 1
        if (type == .hard){
            if (numberOfHits == 2){
                isBroken = true
            }
        } else {
            isBroken = true
        }
    }
    
}
