//
//  Ekran.swift
//  BarKirmaca
//
//  Created by Olcay Taner YILDIZ on 1/23/15.
//  Copyright (c) 2015 Olcay Taner YILDIZ. All rights reserved.
//

import UIKit

class Screen : UIView{
    var parameter : Parameter?
    
    func brickColor(_ type : BrickType)->UIColor{
        switch (type){
            case .normal:
                return UIColor.black
            case .hard:
                return UIColor.brown
            case .faster:
                return UIColor.blue
            case .slower:
                return UIColor.cyan
            case .larger:
                return UIColor.orange
            case .smaller:
                return UIColor.green
            case .life:
                return UIColor.magenta
            case .death:
                return UIColor.red
            case .multiple:
                return UIColor.yellow
        }
    }

    override func draw(_ rect:CGRect){
        var context: CGContext
        var area : CGRect
        var level : Level
        var brickToBeDrawn : Brick
        var paddle : Paddle
        var ball : Ball
        var droppingBrick : DroppingBrick
        var color : UIColor
        var fontSize : CGFloat
        context = UIGraphicsGetCurrentContext()!
        level = parameter!.level
        for i in 0..<level.row{
            for j in 0..<level.column{
                brickToBeDrawn = level.brick(i, column:j)
                if (!brickToBeDrawn.isBroken){
                    color = brickColor(brickToBeDrawn.type)
                    context.setFillColor(color.cgColor)
                    context.fill(brickToBeDrawn.place)
                    context.setStrokeColor(UIColor.gray.cgColor)
                    context.addRect(brickToBeDrawn.place)
                    context.strokePath()
                }
            }
        }
        paddle = parameter!.paddle
        context.setFillColor(UIColor.darkGray.cgColor)
        context.fill(paddle.place)
        context.setStrokeColor(UIColor.gray.cgColor)
        context.addRect(paddle.place)
        context.strokePath()
        for i in 0..<parameter!.numberOfBalls(){
            ball = parameter!.ball(i)
            area = CGRect(x: ball.center.x - ball.radius, y: ball.center.y - ball.radius, width: 2 * ball.radius, height: 2 * ball.radius)
            context.setFillColor(UIColor.purple.cgColor)
            context.fillEllipse(in: area)
        }
        for i in 0..<parameter!.numberOfDroppingBricks(){
            droppingBrick = parameter!.droppingBrick(i)
            color = brickColor(droppingBrick.type)
            context.setFillColor(color.cgColor)
            context.fillEllipse(in: droppingBrick.place)
        }
        ball = parameter!.ball(0)
        for i in 0..<parameter!.numberOfLives{
            area = CGRect(x: 5.0 + CGFloat(i * 2) * ball.radius, y: parameter!.paddle.place.origin.y + 1.4 * parameter!.paddle.place.size.height, width: 1.6 * ball.radius, height: 1.6 * ball.radius)
            context.setFillColor(UIColor.purple.cgColor)
            context.fillEllipse(in: area)
        }
        fontSize = parameter!.screenWidth * 12 / 300
        let pointsProperty = [NSFontAttributeName : UIFont.systemFont(ofSize: fontSize)]
        context.textMatrix = CGAffineTransform(scaleX: 1.0, y: -1.0)
        let pointsText = NSMutableAttributedString(string:String(format: "%d", parameter!.points), attributes:pointsProperty)
        context.textPosition = CGPoint(x : parameter!.screenWidth - pointsText.size().width, y : parameter!.screenHeight - 10 - pointsText.size().height)
        CTLineDraw(CTLineCreateWithAttributedString(pointsText), context)
        fontSize = parameter!.screenWidth * 12 / 100
        let levelProperty = [NSFontAttributeName : UIFont.systemFont(ofSize: fontSize)]
        let levelText = NSMutableAttributedString(string:String(format: "Level %d", parameter!.level.levelNo + 1), attributes:levelProperty)
        context.textPosition = CGPoint(x : parameter!.screenWidth / 2 - levelText.size().width / 2, y : parameter!.screenHeight / 2)
        CTLineDraw(CTLineCreateWithAttributedString(levelText), context)
    }
    
}
