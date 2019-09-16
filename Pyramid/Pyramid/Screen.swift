//
//  Ekran.swift
//  Piramit
//
//  Created by Olcay Taner YILDIZ on 1/9/15.
//  Copyright (c) 2015 Olcay Taner YILDIZ. All rights reserved.
//

import UIKit

class Screen: UIView {

    var cellWidth : CGFloat = 0
    var puzzle : Puzzle?
    
    override func draw(_ rect:CGRect){
        var context: CGContext
        var area : CGRect
        var x, y, leftIndex, fontSize : CGFloat
        context = UIGraphicsGetCurrentContext()!
        if let numberOfSquares = puzzle?.puzzleSize{
            for i in 0..<numberOfSquares{
                for j in 0...i{
                    if (puzzle?.playedValue(i) != j){
                        context.setStrokeColor(UIColor.black.cgColor)
                        context.setLineWidth(1.0)
                    } else {
                        context.setStrokeColor(UIColor.blue.cgColor)
                        context.setLineWidth(3.0)
                    }
                    leftIndex = CGFloat(numberOfSquares - i + 1 + 2 * j) / 2.0
                    x = leftIndex * cellWidth
                    y = CGFloat(i + 1) * cellWidth
                    area = CGRect(x: x, y: y, width: cellWidth, height: cellWidth)
                    context.addRect(area)
                    context.strokePath()
                    if let number = puzzle?.getNumber(i, column:j){
                        fontSize = cellWidth / 1.5
                        let property = [NSFontAttributeName : UIFont.systemFont(ofSize: fontSize)]
                        let numberText = NSMutableAttributedString(string:String(format: "%d", number), attributes:property)
                        context.textMatrix = CGAffineTransform(scaleX: 1.0, y: -1.0)
                        context.textPosition = CGPoint(x:area.origin.x + (cellWidth - numberText.size().width) / 2, y:area.origin.y + 1.5 * cellWidth - numberText.size().height)
                        CTLineDraw(CTLineCreateWithAttributedString(numberText), context)
                    }
                }
            }
        }
    }
    
}
