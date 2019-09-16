//
//  Bulmaca.swift
//  Piramit
//
//  Created by Olcay Taner YILDIZ on 1/9/15.
//  Copyright (c) 2015 Olcay Taner YILDIZ. All rights reserved.
//

import UIKit

class Puzzle {
    fileprivate var numbers : [[Int]] = []
    fileprivate var played : [Int] = []
    var puzzleSize : Int = 0
    
    init(puzzleInfo:String){
        var k: Int
        puzzleSize = Int(sqrt(Double(2 * puzzleInfo.utf16.count)))
        k = 0
        for i in 0..<puzzleSize{
            played.append(-1)
            var row : [Int] = []
            for _ in 0...i{
                row.append(Int(String(Array(puzzleInfo.characters)[k]))!)
                k += 1
            }
            numbers.append(row)
        }
    }
    
    func getNumber(_ row:Int, column:Int)->Int{
        return numbers[row][column]
    }
    
    func playedValue(_ row:Int)->Int{
        return played[row]
    }
    
    func play(_ row: Int, value:Int){
        played[row] = value
    }

    
}
