//
//  ViewController.swift
//  BarKirmaca
//
//  Created by Olcay Taner YILDIZ on 1/22/15.
//  Copyright (c) 2015 Olcay Taner YILDIZ. All rights reserved.
//

import UIKit

class BrickBreaker: UIViewController {
    fileprivate var game : Game?
    fileprivate var levelNo : Int = 0
    fileprivate var timer : Timer?
    fileprivate var moveStarted : Bool = false
    fileprivate var screenWidth : CGFloat = 0
    fileprivate var screenHeight : CGFloat = 0
    fileprivate var difference : CGFloat = 0
    @IBOutlet var screen: Screen!
    
    func newLevel(){
        levelNo += 1
        screen.parameter!.newLevel(game!.level(levelNo))
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(BrickBreaker.onTimer), userInfo: nil, repeats: true)
    }

    override func viewDidLoad() {
        var gameParameter : Parameter
        super.viewDidLoad()
        screenWidth = UIScreen.main.bounds.size.width
        screenHeight = UIScreen.main.bounds.size.height
        levelNo = 0
        game = Game(file: "levels", width: screenWidth)
        gameParameter = Parameter(width: screenWidth, height: screenHeight, level: game!.level(levelNo))
        screen.parameter = gameParameter
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(BrickBreaker.onTimer), userInfo: nil, repeats: true)
    }
    
    func onTimer(){
        var ball : Ball
        var droppingBrick : DroppingBrick
        for i in 0..<screen.parameter!.numberOfBalls(){
            ball = screen.parameter!.ball(i)
            ball.move()
            screen.parameter!.ballContactsWithPaddle(ball)
            if (screen.parameter!.ballContactsWithBrick(ball)){
                timer?.invalidate()
                newLevel()
                return
            }
            if (!screen.parameter!.ballContactsWithScreenBounds(ball, index: i)){
                timer?.invalidate()
            }
        }
        for i in 0..<screen.parameter!.numberOfDroppingBricks(){
            droppingBrick = screen.parameter!.droppingBrick(i)
            droppingBrick.move()
            if (!screen.parameter!.droppingBrickContactsWithPaddle()){
                timer?.invalidate()
            }
            screen.setNeedsDisplay()
        }
    }

    @IBAction func movePaddle(_ panGestureRecognizer: UIPanGestureRecognizer) {
        var p : CGPoint
        p = panGestureRecognizer.location(in: panGestureRecognizer.view)
        if (panGestureRecognizer.state == UIGestureRecognizerState.began){
            if (screen.parameter!.contactsWithPaddle(p.x, y : p.y)){
                difference = p.x - screen.parameter!.paddle.place.origin.x
                moveStarted = true
            } else {
                moveStarted = false
            }
        } else {
            if (panGestureRecognizer.state == UIGestureRecognizerState.ended){
                if (moveStarted){
                    screen.parameter!.paddleSetNewPosition(p.x - difference)
                    screen.setNeedsDisplay()
                }
                moveStarted = false
            } else {
                if (panGestureRecognizer.state == UIGestureRecognizerState.changed){
                    if (moveStarted){
                        screen.parameter!.paddleSetNewPosition(p.x - difference)
                        screen.setNeedsDisplay()
                    }
                }
            }
        }
    }

}

