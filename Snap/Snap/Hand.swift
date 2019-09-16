//
//  El.swift
//  Pisti
//
//  Created by Olcay Taner YILDIZ on 1/18/15.
//  Copyright (c) 2015 Olcay Taner YILDIZ. All rights reserved.
//

class Hand{
    fileprivate var cards: [Card] = []
    fileprivate var isPlayed : [Bool] = []
    
    init(card1: Card, card2: Card, card3: Card, card4: Card){
        cards.append(card1)
        cards.append(card2)
        cards.append(card3)
        cards.append(card4)
        for _ in 0...3{
            isPlayed.append(false)
        }
    }
    
    func play(_ position : Int)->Card{
        isPlayed[position] = true
        return cards[position]
    }
    
    func getCard(_ position : Int)->Card{
        return cards[position]
    }
    
    func isPlayed(_ position : Int)->Bool{
        return isPlayed[position]
    }
}
