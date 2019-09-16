//
//  Deste.swift
//  Pisti
//
//  Created by Olcay Taner YILDIZ on 1/18/15.
//  Copyright (c) 2015 Olcay Taner YILDIZ. All rights reserved.
//

import Foundation

class Deck{
    fileprivate var cards : [Card] = []
    
    init(){
        dealCards()
        shuffleCards()
    }
    
    func dealCards(){
        var type : String
        var card : Card
        for i in 0...3{
            switch (i){
                case 0:
                    type = "diamond"
                case 1:
                    type = "heart"
                case 2:
                    type = "club"
                case 3:
                    type = "spade"
                default:
                    type = ""
            }
            for j in 1...13{
                card = Card(type:type, value:j)
                cards.append(card)
            }
        }
    }
    
    func shuffleCards(){
        var remained , changed : Int
        var tmpCard : Card
        for i in 0...51{
            remained = 52 - i
            changed = i + Int(arc4random_uniform(UInt32(remained)))
            tmpCard = cards[i]
            cards[i] = cards[changed]
            cards[changed] = tmpCard
        }
    }
    
    func dealHand()->Hand{
        var hand : Hand
        var count : Int
        count = cards.count
        hand = Hand(card1: cards[count - 1], card2: cards[count - 2], card3: cards[count - 3], card4: cards[count - 4])
        for _ in 0...3{
            cards.removeLast()
        }
        return hand
    }
    
    func dealPile(_ pile : Pile){
        for _ in 0...3{
            pile.addCard(cards[cards.count - 1])
            cards.removeLast()
        }
    }
    
}
