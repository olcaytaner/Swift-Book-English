//
//  ViewController.swift
//  Pyramid
//
//  Created by Olcay Taner Yıldız on 01/10/16.
//  Copyright © 2016 Olcay Taner Yıldız. All rights reserved.
//

import UIKit

class Pyramid: UIViewController {
    
    @IBOutlet var screen: Screen!
    fileprivate var puzzles : [Puzzle] = []

    override func viewDidLoad() {
        var position : Int
        super.viewDidLoad()
        let puzzleInformation : [String] = ["443252145336141522663", "234524435626143614625", "161524246313452326215", "355424315665631243245", "653634542621351325265", "543236612135654465432", "445385279314268683141725276595138379834941283", "345342468929768161215485464767167583529398619", "233154981265474421359918793858356165737438971", "134925548326192374564412375353491475182356918"]
        for i in 0..<puzzleInformation.count{
            puzzles.append(Puzzle(puzzleInfo: puzzleInformation[i]))
        }
        position = Int(arc4random_uniform(UInt32(puzzles.count)))
        screen.puzzle = puzzles[position]
        if let numberOfSquares = screen.puzzle?.puzzleSize{
            screen.cellWidth = UIScreen.main.bounds.size.width / CGFloat(numberOfSquares + 2)
        }
        screen.setNeedsDisplay()
    }
    
    @IBAction func clickCell(_ sender: UITapGestureRecognizer) {
        let point : CGPoint = sender.location(in: self.view)
        var area : CGRect
        var x, y, leftIndex : CGFloat
        if let numberOfSquares = screen.puzzle?.puzzleSize{
            for i in 0..<numberOfSquares{
                for j in 0...i{
                    leftIndex = CGFloat(numberOfSquares - i + 1 + 2 * j) / 2.0
                    x = leftIndex * screen.cellWidth
                    y = CGFloat(i + 1) * screen.cellWidth
                    area = CGRect(x: x, y: y, width: screen.cellWidth, height: screen.cellWidth)
                    if (point.x >= area.origin.x && point.x <= area.origin.x + area.size.width &&
                        point.y >= area.origin.y && point.y <= area.origin.y + area.size.height){
                        screen.puzzle?.play(i, value:j)
                        screen.setNeedsDisplay()
                        return
                    }
                }
            }
        }
    }

}

