//
//  Oyun.swift
//  BarKirmaca
//
//  Created by Olcay Taner YILDIZ on 1/23/15.
//  Copyright (c) 2015 Olcay Taner YILDIZ. All rights reserved.
//

import UIKit

class Game{
    fileprivate var levels : [Level] = []

    init(file : String, width : CGFloat){
        var fileName, fileContents : String
        var scanner : Scanner
        var row : Int = 0
        var column : Int = 0
        var numberOfLevels : Int = 0
        var level : Level
        var levelInfo : NSString?
        fileName = Bundle.main.path(forResource: file, ofType: "txt")!
        do{
            fileContents = try String(contentsOfFile:fileName, encoding:String.Encoding.utf8)
        }
        catch{
            fileContents = ""
        }
        scanner = Scanner(string: fileContents)
        scanner.scanInt(&numberOfLevels)
        for i in 0..<numberOfLevels{
            scanner.scanInt(&row)
            scanner.scanInt(&column)
            level = Level(row : row, column : column, width : width, levelNo : i)
            for j in 0..<row{
                scanner.scanUpTo("\n", into : &levelInfo)
                level.constructRow(j, rowInfo : levelInfo! as String)
            }
            levels.append(level)
        }
    }
    
    func level(_ position : Int)->Level{
        return levels[position]
    }

}
