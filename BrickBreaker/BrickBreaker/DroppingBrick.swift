//
//  DusenTugla.swift
//  BarKirmaca
//
//  Created by Olcay Taner YILDIZ on 1/23/15.
//  Copyright (c) 2015 Olcay Taner YILDIZ. All rights reserved.
//

import UIKit

class DroppingBrick{
    var type : BrickType
    var place : CGRect
    fileprivate var speed : CGPoint
    
    init(type : BrickType, place : CGRect, height : CGFloat){
        self.type = type
        self.place = place
        speed = CGPoint(x: 0, y: height / 1000.0)
    }
    
    func move(){
        place.origin.x += speed.x
        place.origin.y += speed.y
    }
    
    func contactsWithPaddle(_ paddle : Paddle)->Bool{
        if (place.origin.x + place.size.width > paddle.place.origin.x && place.origin.x < paddle.place.origin.x + paddle.place.size.width
    && place.origin.y + place.size.height > paddle.place.origin.y && place.origin.y < paddle.place.origin.y + paddle.place.size.height){
            return true
        } else {
            return false
        }
    }
}
