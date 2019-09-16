//
//  Ekran.swift
//  SatrancTaslari
//
//  Created by Olcay Taner YILDIZ on 1/18/15.
//  Copyright (c) 2015 Olcay Taner YILDIZ. All rights reserved.
//

import UIKit

class Screen : UIView{
    var puzzleSize : CGFloat = 0
    var cellWidth : CGFloat = 0
    var puzzle : Puzzle?
    var table : [Int] = []
    var placeOnBoard : [Bool] = []
    var moveX : CGFloat = 0
    var moveY : CGFloat = 0
    var isMoving : Bool = false
    var whichPiece : Int = -1

    func piecePicture(_ piece : Int)->UIImage{
        switch (piece){
            case 0:
                return UIImage(named:"king.png")!
            case 1:
                return UIImage(named:"queen.png")!
            case 2, 3:
                return UIImage(named:"rook.png")!
            case 4, 5:
                return UIImage(named:"bishop.png")!
            case 6, 7:
                return UIImage(named:"knight.png")!
            default:
                return UIImage(named:"king.png")!
        }
    }
    
    override func draw(_ rect:CGRect){
        var x, y : Int
        let TOP : CGFloat = 50
        var context: CGContext
        var rectangle, area : CGRect
        var piece, number : UIImage
        var attack : Attack
        var W, H, w, h, l, posx, posy : CGFloat
        context = UIGraphicsGetCurrentContext()!
        context.setStrokeColor(UIColor.black.cgColor)
        for i in 0...8{
            context.move(to: CGPoint(x: CGFloat(i + 1) * cellWidth, y: cellWidth + TOP))
            context.addLine(to: CGPoint(x: CGFloat(i + 1) * cellWidth, y: 9 * cellWidth + TOP))
            context.strokePath()
            context.move(to: CGPoint(x: cellWidth, y: CGFloat(i + 1) * cellWidth + TOP))
            context.addLine(to: CGPoint(x: 9 * cellWidth, y: CGFloat(i + 1) * cellWidth + TOP))
            context.strokePath()
        }
        context.setStrokeColor(UIColor.blue.cgColor)
        context.setLineWidth(3.0)
        if let puzzle = puzzle{
            for i in 0..<puzzle.numberOfPossiblePlaces(){
                let square : Square = puzzle.possiblePlace(i)
                x = square.x
                y = square.y
                if (table[i] == -1){
                    rectangle = CGRect(x: CGFloat(y + 1) * cellWidth, y: TOP + CGFloat(x + 1) * cellWidth, width: cellWidth, height: cellWidth)
                    context.addRect(rectangle)
                    context.strokePath()
                } else {
                    if (isMoving && whichPiece >= 8 && whichPiece - 8 == i){
                        piece = piecePicture(table[i])
                        area = CGRect(x: moveX, y: TOP + moveY, width: cellWidth - 2, height: cellWidth - 2)
                        piece.draw(in: area)
                    } else {
                        piece = piecePicture(table[i])
                        area = CGRect(x: CGFloat(y + 1) * cellWidth + 1, y: TOP + CGFloat(x + 1) * cellWidth + 1, width: cellWidth - 1, height: cellWidth - 1)
                        piece.draw(in: area)
                    }
                }
            }
            for i in 0..<puzzle.numberOfAttacks(){
                attack = puzzle.attack(i)
                x = attack.x
                y = attack.y
                posx = CGFloat(y + 1) * cellWidth - 2
                posy = CGFloat(x + 1) * cellWidth
                let sayiString : String = String(format:"%d.png", attack.numberOfAttacks)
                number = UIImage(named:sayiString)!
                w = number.size.width
                h = number.size.height
                l = cellWidth / 2
                if (h > w){
                    W = (w * l) / h
                    area = CGRect(x: posx + (cellWidth - W) / 2, y: TOP + posy + (cellWidth - l) / 2, width: cellWidth / 2, height: cellWidth / 2)
                    number.draw(in: area)
                } else {
                    H = (h * l) / w
                    area = CGRect(x: posx + (cellWidth - l) / 2, y: TOP + posy + (cellWidth - H) / 2, width: cellWidth / 2, height: cellWidth / 2)
                    number.draw(in: area)
                }
            }
        }
        for i in 0...7{
            if (!placeOnBoard[i]){
                if (isMoving && whichPiece < 8 && whichPiece == i){
                    piece = piecePicture(i)
                    area = CGRect(x: moveX, y: TOP + moveY, width: cellWidth - 2, height: cellWidth - 2)
                    piece.draw(in: area)
                } else {
                    piece = piecePicture(i)
                    area = CGRect(x: CGFloat(i + 1) * cellWidth + 1, y: TOP + 9 * cellWidth + 1, width: cellWidth - 1, height: cellWidth - 1)
                    piece.draw(in: area)
                }
            }
        }
    }

}
