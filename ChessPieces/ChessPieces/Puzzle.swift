//
//  Bulmaca.swift
//  SatrancTaslari
//
//  Created by Olcay Taner YILDIZ on 1/18/15.
//  Copyright (c) 2015 Olcay Taner YILDIZ. All rights reserved.
//

class Puzzle{
    fileprivate var possiblePlaces : [Square] = []
    fileprivate var attacks : [Attack] = []
    
    func addPossiblePlace(_ place : Square){
        possiblePlaces.append(place)
    }
    
    func possiblePlaceNo(_ x : Int, y : Int)->Int{
        for i in 0..<possiblePlaces.count{
            let square : Square = possiblePlaces[i]
            if (square.x == x && square.y == y){
                return i
            }
        }
        return -1
    }
    
    func numberOfPossiblePlaces()->Int{
        return possiblePlaces.count
    }
    
    func possiblePlace(_ position : Int)->Square{
        return possiblePlaces[position]
    }
    
    func numberOfAttacks()->Int{
        return attacks.count
    }
    
    func addAttack(_ attack : Attack){
        attacks.append(attack)
    }
    
    func attack(_ position : Int)->Attack{
        return attacks[position]
    }
    
    func kingControl(_ solution : Solution, x : Int, y:Int)->Int{
        var who : Int
        for i in -1...1{
            for j in -1...1{
                who = possiblePlaceNo(x + i, y : y + j)
                if (who != -1 && solution.pieceName(who) == "king"){
                    return 1
                }
            }
        }
        return 0
    }
    
    func bishopControl(_ solution : Solution, x : Int, y : Int)->Int{
        let xIncrease : [Int] = [1, 1, -1, -1]
        let yIncrease : [Int] = [1, -1, 1, -1]
        var who, count, a, b : Int
        count = 0
        for j in 0...3{
            for i in 1...7{
                a = x + i * xIncrease[j]
                b = y + i * yIncrease[j]
                who = possiblePlaceNo(a, y : b)
                if (who != -1){
                    if (solution.pieceName(who).hasPrefix("bishop")){
                        count += 1
                    }else{
                        break
                    }
                }
            }
        }
        return count
    }
    
    func rookControl(_ solution : Solution, x : Int, y : Int)->Int{
        let xIncrease : [Int] = [1, -1, 0, 0]
        let yIncrease : [Int] = [0, 0, 1, -1]
        var who, count, a, b : Int
        count = 0
        for j in 0...3{
            for i in 1...7{
                a = x + i * xIncrease[j]
                b = y + i * yIncrease[j]
                who = possiblePlaceNo(a, y : b)
                if (who != -1){
                    if (solution.pieceName(who).hasPrefix("rook")){
                        count += 1
                    }else{
                        break
                    }
                }
            }
        }
        return count
    }
    
    func queenControl(_ solution : Solution, x : Int, y : Int)->Int{
        let xIncrease : [Int] = [1, 1, -1, -1, 1, -1, 0, 0]
        let yIncrease : [Int] = [1, -1, 1, -1, 0, 0, 1, -1]
        var who, a, b : Int
        for j in 0...7{
            for i in 1...7{
                a = x + i * xIncrease[j]
                b = y + i * yIncrease[j]
                who = possiblePlaceNo(a, y : b)
                if (who != -1){
                    if (solution.pieceName(who) == "queen"){
                        return 1
                    } else {
                        break
                    }
                }
            }
        }
        return 0
    }
    
    func knightControl(_ solution : Solution, x : Int, y : Int)->Int{
        let xArtis : [Int] = [1, 2, 1, -1, -1, 2, -2, -2]
        let yArtis : [Int] = [-2, -1, 2, 2, -2, 1, 1, -1]
        var kim, a, b, count : Int
        count = 0
        for j in 0...7{
            a = x + xArtis[j]
            b = y + yArtis[j]
            kim = possiblePlaceNo(a, y : b)
            if (kim != -1){
                if (solution.pieceName(kim).hasPrefix("knight")){
                    count += 1
                } else {
                    break
                }
            }
        }
        return count
    }
    
    func satisfiesConditions(_ solution : Solution)->Bool{
        var x, y, count : Int
        for i in 0..<attacks.count{
            let attack : Attack = attacks[i]
            x = attack.x
            y = attack.y
            count = kingControl(solution,  x : x, y : y) + bishopControl(solution, x : x, y : y) + rookControl(solution, x : x, y : y) + queenControl(solution, x : x, y : y) + knightControl(solution, x : x, y : y)
            if (count != attack.numberOfAttacks){
                return false
            }
        }
        return true
    }

    func satisfiesConditionsTemporarily(_ solution : Solution)->Bool{
        var x, y, count : Int
        for i in 0..<attacks.count{
            let attack : Attack = attacks[i]
            x = attack.x
            y = attack.y
            count = kingControl(solution,  x : x, y : y) + bishopControl(solution, x : x, y : y) + rookControl(solution, x : x, y : y) + queenControl(solution, x : x, y : y) + knightControl(solution, x : x, y : y)
            if (count > attack.numberOfAttacks){
                return false
            }
        }
        return true
    }
    
}
