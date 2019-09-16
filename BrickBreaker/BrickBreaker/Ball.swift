//
//  Top.swift
//  BarKirmaca
//
//  Created by Olcay Taner YILDIZ on 1/23/15.
//  Copyright (c) 2015 Olcay Taner YILDIZ. All rights reserved.
//

import UIKit

class Ball{
    var center : CGPoint
    fileprivate var speed : CGPoint
    var radius : CGFloat
    
    init(paddleX : CGFloat, paddleY : CGFloat, screenWidth: CGFloat){
        speed = CGPoint(x: -screenWidth / 600.0, y: -screenWidth / 600.0)
        radius = screenWidth / 50
        center = CGPoint(x: paddleX + radius, y: paddleY - radius)
    }
    
    func move(){
        center.x += speed.x
        center.y += speed.y
    }
    
    func contactsWithScreenBounds(_ screenWidth : CGFloat, screenHeight : CGFloat)->Bool{
        if (center.x < 0 || center.x > screenWidth){
            speed.x *= -1
        }
        if (center.y < 0){
            speed.y *= -1
        }
        if (center.y > screenHeight){
            return true
        } else {
            return false
        }
    }
    
    func contactsWithBrick(_ brick : Brick)->Bool{
        if (center.x + radius > brick.place.origin.x && center.x - radius < brick.place.origin.x + brick.place.size.width
    && center.y + radius > brick.place.origin.y && center.y - radius < brick.place.origin.y + brick.place.size.height){
            speed.y *= -1
            return true
        } else {
            return false
        }
    }
    
    func contactsWithPaddle(_ paddle : Paddle)->Bool{
        if (center.x + radius > paddle.place.origin.x && center.x - radius < paddle.place.origin.x + paddle.place.size.width
    && center.y + radius > paddle.place.origin.y && center.y - radius < paddle.place.origin.y + paddle.place.size.height){
            speed.y *= -1
            return true
        } else {
            return false
        }
    }
    
    func speedUp(){
        speed.x *= 1.25
        speed.y *= 1.25
    }
    
    func slowDown(){
        speed.x *= 0.8
        speed.y *= 0.8
    }

}
