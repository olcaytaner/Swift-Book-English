//
//  Parametre.swift
//  BarKirmaca
//
//  Created by Olcay Taner YILDIZ on 1/23/15.
//  Copyright (c) 2015 Olcay Taner YILDIZ. All rights reserved.
//

import UIKit

class Parameter{
    var numberOfLives : Int
    var paddle : Paddle
    var level : Level
    var points : Int
    var screenWidth : CGFloat = 0
    var screenHeight : CGFloat = 0
    fileprivate var balls : [Ball] = []
    fileprivate var droppingBricks : [DroppingBrick] = []
    
    func newLevel(_ level : Level){
        self.level = level
        paddle = Paddle(screenWidth: screenWidth, screenHeight : screenHeight)
        balls.removeAll(keepingCapacity: false)
        balls.append(Ball(paddleX: paddle.place.origin.x, paddleY: paddle.place.origin.y, screenWidth: screenWidth))
    }
    
    init(width : CGFloat, height : CGFloat, level : Level){
        screenWidth = width
        screenHeight = height
        numberOfLives = 3
        points = 0
        paddle = Paddle(screenWidth: screenWidth, screenHeight : screenHeight)
        self.level = level
        balls.append(Ball(paddleX: paddle.place.origin.x, paddleY: paddle.place.origin.y, screenWidth: screenWidth))
    }
    
    func numberOfBalls()->Int{
        return balls.count
    }
    
    func ball(_ position : Int)->Ball{
        return balls[position]
    }
    
    func numberOfDroppingBricks()->Int{
        return droppingBricks.count
    }
    
    func droppingBrick(_ pozisyon : Int)->DroppingBrick{
        return droppingBricks[pozisyon]
    }
    
    func ballContactsWithScreenBounds(_ ball : Ball, index : Int)->Bool{
        var newBall : Ball
        if (ball.contactsWithScreenBounds(screenWidth, screenHeight : screenHeight)){
            balls.remove(at: index)
            if (balls.count == 0){
                numberOfLives -= 1
                if (numberOfLives > 0){
                    newBall = Ball(paddleX : paddle.place.origin.x, paddleY : paddle.place.origin.y, screenWidth : screenWidth)
                    balls.append(newBall)
                } else {
                    return false
                }
            }
        }
        return true
    }
    
    func ballContactsWithBrick(_ ball : Ball)->Bool{
        var brick : Brick
        var droppingBrick : DroppingBrick
        for i in 0..<level.row{
            for j in 0..<level.column{
                brick = level.brick(i, column : j)
                if (!brick.isBroken && ball.contactsWithBrick(brick)){
                    brick.hit()
                    if (brick.isBroken){
                        if (brick.type != .hard){
                            points += 10
                        }else{
                            points += 20
                        }
                        if (brick.type != .normal && brick.type != .hard){
                            droppingBrick = DroppingBrick(type: brick.type, place : brick.place, height : screenHeight)
                            droppingBricks.append(droppingBrick)
                        }
                        if (level.isFinished()){
                            return true
                        }
                    }
                }
            }
        }
        return false
    }
    
    func ballContactsWithPaddle(_ ball : Ball)->Bool{
        return ball.contactsWithPaddle(paddle)
    }
    
    func contactsWithPaddle(_ x : CGFloat, y : CGFloat)->Bool{
        if (x > paddle.place.origin.x && x < paddle.place.origin.x + paddle.place.size.width && y > paddle.place.origin.y && y < paddle.place.origin.y + paddle.place.size.height){
            return true
        } else {
            return false
        }
    }
    
    func paddleSetNewPosition(_ x : CGFloat){
        if (x > 0 && x < screenWidth - paddle.place.size.width){
            paddle.setNewPosition(x)
        }
    }
    
    func droppingBrickContactsWithPaddle()->Bool{
        var newBall : Ball
        var droppingBrick : DroppingBrick
        for i in 0..<droppingBricks.count{
            droppingBrick = droppingBricks[i]
            if (droppingBrick.contactsWithPaddle(paddle)){
                switch (droppingBrick.type){
                    case .faster:
                        for ball in balls{
                            ball.speedUp()
                        }
                    case .slower:
                        for ball in balls{
                            ball.slowDown()
                        }
                    case .larger:
                        paddle.grow()
                    case .smaller:
                        paddle.shrink()
                    case .life:
                        numberOfLives += 1
                    case .death:
                        numberOfLives -= 1
                        if (numberOfLives == 0){
                            return false
                        }
                    case .multiple:
                        newBall = Ball(paddleX : paddle.place.origin.x, paddleY : paddle.place.origin.y, screenWidth : screenWidth)
                        balls.append(newBall)
                    default:
                        break
                }
                droppingBricks.remove(at: i)
                break
            }
        }
        return true
    }
}
