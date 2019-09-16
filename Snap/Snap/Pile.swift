//
//  Orta.swift
//  Pisti
//
//  Created by Olcay Taner YILDIZ on 1/18/15.
//  Copyright (c) 2015 Olcay Taner YILDIZ. All rights reserved.
//

class Pile{
    fileprivate var cards : [Card] = []
    
    func topCard()->Card?{
        if (cards.count > 0){
            return cards[cards.count - 1]
        }
        return nil
    }
    
    func addCard(_ card : Card){
        cards.append(card)
    }
    
    func numberOfCards()->Int{
        return cards.count
    }
    
    func winExists()->Bool{
        var topCard, bottomCard : Card
        if (cards.count >= 2){
            topCard = cards[cards.count - 1]
            bottomCard = cards[cards.count - 2]
            if (topCard.value == bottomCard.value || topCard.value == 11){
                return true
            } else {
                return false
            }
        }
        return false
    }
    
    func sendToStack(_ stack : Stack){
        if (cards.count == 2){
            if let card = topCard(){
                stack.addSnap(card)
            }
        } else {
            for card in cards{
                stack.addNormal(card)
            }
        }
        cards.removeAll(keepingCapacity: false)
    }
}
