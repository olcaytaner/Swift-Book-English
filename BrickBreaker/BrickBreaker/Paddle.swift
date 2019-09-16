//
//  Cubuk.swift
//  BarKirmaca
//
//  Created by Olcay Taner YILDIZ on 1/23/15.
//  Copyright (c) 2015 Olcay Taner YILDIZ. All rights reserved.
//

import UIKit

class Paddle{
    var place : CGRect
    
    init(screenWidth : CGFloat, screenHeight: CGFloat){
        place = CGRect(x: screenWidth / 2 - 0.075 * screenWidth, y: screenHeight - 3.5 * 0.05 * screenWidth, width: 0.15 * screenWidth, height: 0.05 * screenWidth)
    }
    
    func grow(){
        place.size.width *= 1.25
    }
    
    func shrink(){
        place.size.width *= 0.8
    }
    
    func setNewPosition(_ x : CGFloat){
        place.origin.x = x
    }
}
