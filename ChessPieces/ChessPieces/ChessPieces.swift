//
//  ViewController.swift
//  SatrancTaslari
//
//  Created by Olcay Taner YILDIZ on 1/18/15.
//  Copyright (c) 2015 Olcay Taner YILDIZ. All rights reserved.
//

import UIKit

class ChessPieces: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet var screen: Screen!
    var puzzle : Puzzle?
    var finished : Bool = false
    var numberOfPuzzles : Int = 0
    var puzzles : [Puzzle] = []
    var solution : Solution?
    var timer : Timer?
    var secondsPassed : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        screen.puzzleSize = UIScreen.main.bounds.size.width
        screen.cellWidth = screen.puzzleSize / 10
        readFile()
        newPuzzle()
    }

    func readFile(){
        var fileName, fileContents : String
        var scanner : Scanner
        var x : Int = 0
        var y: Int = 0
        var numberOfAttacks : Int = 0
        var numberOfSquares : Int = 0
        var square : Square
        var attack : Attack
        fileName = Bundle.main.path(forResource: "bulmacalar", ofType: "txt")!
        fileContents = try! String(contentsOfFile:fileName, encoding:String.Encoding.utf8)
        scanner = Scanner(string: fileContents)
        scanner.scanInt(&numberOfPuzzles)
        for _ in 0..<numberOfPuzzles{
            puzzle = Puzzle()
            if let puzzle = puzzle{
                for _ in 0...7{
                    scanner.scanInt(&x)
                    scanner.scanInt(&y)
                    square = Square(x : x - 1, y : y - 1)
                    puzzle.addPossiblePlace(square)
                }
                scanner.scanInt(&numberOfSquares)
                for _ in 0..<numberOfSquares{
                    scanner.scanInt(&x)
                    scanner.scanInt(&y)
                    scanner.scanInt(&numberOfAttacks)
                    attack = Attack(x : x - 1, y : y - 1, numberOfAttacks : numberOfAttacks)
                    puzzle.addAttack(attack)
                }
                puzzles.append(puzzle)
            }
        }
    }
    
    func newPuzzle(){
        finished = false
        puzzle = puzzles[Int(arc4random_uniform(UInt32(puzzles.count)))]
        screen.table.removeAll(keepingCapacity: false)
        screen.placeOnBoard.removeAll(keepingCapacity: false)
        for _ in 0...7{
            screen.table.append(-1)
            screen.placeOnBoard.append(false)
        }
        screen.isMoving = false
        screen.puzzle = puzzle
        secondsPassed = 0
        if let timer = timer{
            timer.invalidate()
        }
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ChessPieces.onTimer), userInfo: nil, repeats: true)
        screen.setNeedsDisplay()
    }
    
    func controlSolution(){
        var message : String = ""
        var alarm : UIAlertView
        solution = Solution()
        if let solution = solution{
            if let puzzle = puzzle{
                for i in 0...7{
                    solution.addWithPieceNo(screen.table[i])
                    if (!puzzle.satisfiesConditions(solution)){
                        message = "Your solution is wrong!"
                    } else {
                        message = "Your solution is correct!"
                    }
                }
            }
        }
        alarm = UIAlertView(title:"Puzzle Over!", message:message, delegate:self, cancelButtonTitle:"Cancel")
        alarm.show()
    }
    
    func searchForSolution(){
        var candidates : [Piece] = []
        if let puzzle = puzzle{
            if let solution = solution{
                if (!puzzle.satisfiesConditionsTemporarily(solution)){
                    return
                } else {
                    if (solution.numberOfPieces() == 8){
                        if (puzzle.satisfiesConditions(solution)){
                            finished = true
                        }
                    }
                    else{
                        candidates = solution.generateCandidates()
                        for piece in candidates{
                            solution.addPiece(piece)
                            searchForSolution()
                            if (finished){
                                return
                            }
                            solution.removePiece()
                        }
                    }
                }
            }
        }
    }
    
    func solve(){
        finished = false
        solution = Solution()
        searchForSolution()
        if let solution = solution{
            screen.table.removeAll(keepingCapacity: false)
            screen.placeOnBoard.removeAll(keepingCapacity: false)
            for i in 0...7{
                screen.table.append(solution.pieceNo(i))
                screen.placeOnBoard.append(true)
            }
        }
    }
    
    func onTimer(){
        secondsPassed += 1
        if (secondsPassed % 60 < 10){
            if (secondsPassed < 600){
                timeLabel.text = String(format:"0%d:0%d", secondsPassed / 60, secondsPassed % 60)
            } else {
                timeLabel.text = String(format:"%d:0%d", secondsPassed / 60, secondsPassed % 60)
            }
        } else {
            if (secondsPassed < 600){
                timeLabel.text = String(format:"0%d:%2d", secondsPassed / 60, secondsPassed % 60)
            } else {
                timeLabel.text = String(format:"%d:%2d", secondsPassed / 60, secondsPassed % 60)
            }
        }
    }

    @IBAction func movePiece(_ gestureRecognizer: UIPanGestureRecognizer) {
        var position, posx, posy: Int
        var x, y: CGFloat
        var p : CGPoint
        p = gestureRecognizer.location(in: gestureRecognizer.view)
        x = p.x
        y = p.y - 50
        if let puzzle = puzzle{
            if (gestureRecognizer.state == UIGestureRecognizerState.began){
                if (y < 9 * screen.cellWidth){
                    posx = Int(x / screen.cellWidth - 1)
                    posy = Int(y / screen.cellWidth - 1)
                    position = puzzle.possiblePlaceNo(posy, y : posx)
                    if (position != -1 && screen.table[position] != -1){
                        screen.whichPiece = position + 8
                        screen.isMoving = true
                        screen.setNeedsDisplay()
                    }
                } else {
                    posx = Int(x / screen.cellWidth - 1)
                    if (posx >= 0 && posx < 8 && !screen.placeOnBoard[posx]){
                        screen.whichPiece = posx
                        screen.isMoving = true
                        screen.setNeedsDisplay()
                    }
                }
            } else {
                if (gestureRecognizer.state == UIGestureRecognizerState.ended){
                    screen.isMoving = false
                    if (y < 9 * screen.cellWidth){
                        posx = Int(x / screen.cellWidth - 1)
                        posy = Int(y / screen.cellWidth - 1)
                        position = puzzle.possiblePlaceNo(posy, y : posx)
                        if (position != -1 && screen.table[position] == -1 && screen.whichPiece >= 0 && screen.whichPiece < 8 && !screen.placeOnBoard[screen.whichPiece]){
                            screen.placeOnBoard[screen.whichPiece] = true
                            screen.table[position] = screen.whichPiece
                        }
                    } else {
                        posx = Int(x / screen.cellWidth - 1)
                        if (posx >= 0 && posx < 8 && screen.whichPiece >= 8 && screen.placeOnBoard[screen.table[screen.whichPiece - 8]]){
                            screen.placeOnBoard[screen.table[screen.whichPiece - 8]] = false
                            screen.table[screen.whichPiece - 8] = -1
                        }
                    }
                    screen.setNeedsDisplay()
                } else {
                    if (gestureRecognizer.state == UIGestureRecognizerState.changed){
                        screen.moveX = x - screen.cellWidth / 2
                        screen.moveY = y - screen.cellWidth / 2
                        screen.setNeedsDisplay()
                    }
                }
            }
        }
    }
    
    @IBAction func controlClick(_ sender: UIButton) {
        controlSolution()
        if let timer = timer{
            timer.invalidate()
        }
    }
    
    @IBAction func newPuzzleClick(_ sender: UIButton) {
        newPuzzle()
    }
    
    @IBAction func solveClick(_ sender: UIButton) {
        solve()
        screen.setNeedsDisplay()
        if let timer = timer{
            timer.invalidate()
        }
    }
    
}

