//
//  Kazanc.swift
//  Pisti
//
//  Created by Olcay Taner YILDIZ on 1/18/15.
//  Copyright (c) 2015 Olcay Taner YILDIZ. All rights reserved.
//

class Stack{
    fileprivate var normalCards : [Card] = []
    fileprivate var snapCards : [Card] = []
    
    func addNormal(_ card : Card){
        normalCards.append(card)
    }
    
    func addSnap(_ card : Card){
        snapCards.append(card)
    }
    
    func numberOfCards()->Int{
        return normalCards.count + 2 * snapCards.count
    }
    
    func points()->Int{
      var points : Int = 0
        for card in snapCards{
            if (card.value == 11){
                points += 20
            } else {
                points += 10
            }
        }
        for card in normalCards{
            if (card.value == 1 || card.value == 11){
                points += 1
            } else {
                if (card.value == 2 && card.type == "club"){
                    points += 2
                } else {
                    if (card.value == 10 && card.type == "diamond"){
                        points += 3
                    }
                }
            }
        }
        return points
    }
    
}
