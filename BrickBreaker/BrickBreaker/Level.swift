//
//  Seviye.swift
//  BarKirmaca
//
//  Created by Olcay Taner YILDIZ on 1/23/15.
//  Copyright (c) 2015 Olcay Taner YILDIZ. All rights reserved.
//

import UIKit

class Level{
    var row : Int = 0
    var column : Int = 0
    var levelNo : Int = 0
    fileprivate var rows : [[Brick]] = []
    fileprivate var brickWidth : CGFloat = 0
    fileprivate var brickHeight : CGFloat = 0
    
    init(row : Int, column : Int, width : CGFloat, levelNo : Int){
        self.row = row
        self.column = column
        self.levelNo = levelNo
        brickWidth = width / CGFloat(column)
        brickHeight = 0.7 * brickWidth
    }
    
    func isFinished()->Bool{
        var brick : Brick
        for i in 0..<row{
            for j in 0..<column{
                brick = rows[i][j]
                if (!brick.isBroken){
                    return false
                }
            }
        }
        return true
    }
    
    func brick(_ row : Int, column : Int)->Brick{
        return rows[row][column]
    }
    
    func constructRow(_ rowNo : Int, rowInfo : String){
        var place: CGRect
        var newRow : [Brick] = []
        for i in 0..<rowInfo.characters.count{
            place = CGRect(x: CGFloat(i) * brickWidth, y: CGFloat(rowNo) * brickHeight, width: brickWidth, height: brickHeight)
            switch (rowInfo[rowInfo.characters.index(rowInfo.startIndex, offsetBy: i)]){
                case "1":
                    newRow.append(Brick(type: .normal, place: place))
                case "2":
                    newRow.append(Brick(type: .hard, place: place))
                case "3":
                    newRow.append(Brick(type: .faster, place: place))
                case "4":
                    newRow.append(Brick(type: .slower, place: place))
                case "5":
                    newRow.append(Brick(type: .larger, place: place))
                case "6":
                    newRow.append(Brick(type: .smaller, place: place))
                case "7":
                    newRow.append(Brick(type: .life, place: place))
                case "8":
                    newRow.append(Brick(type: .death, place: place))
                case "9":
                    newRow.append(Brick(type: .multiple, place: place))
                default:
                    break
            }
        }
        rows.append(newRow)
    }

}
