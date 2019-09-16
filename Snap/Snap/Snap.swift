//
//  ViewController.swift
//  Pisti
//
//  Created by Olcay Taner YILDIZ on 1/15/15.
//  Copyright (c) 2015 Olcay Taner YILDIZ. All rights reserved.
//

import UIKit

class Snap: UIViewController, CAAnimationDelegate {
    
    @IBOutlet var closedCards: [UIImageView]!
    @IBOutlet var computerCards: [UIImageView]!
    @IBOutlet var cards: [UIImageView]!
    @IBOutlet weak var middleCard: UIImageView!
    
    fileprivate var animationCard : UIImageView?
    fileprivate var deck : Deck = Deck()
    fileprivate var pile : Pile = Pile()
    fileprivate var human : Hand?
    fileprivate var computer : Hand?
    fileprivate var humanStack : Stack = Stack()
    fileprivate var computerStack : Stack = Stack()
    fileprivate var numberOfDeals : Int = 0
    fileprivate var moveCount : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startGame()
    }
    
    @IBAction func cardClick(_ sender: UITapGestureRecognizer) {
        let point : CGPoint = sender.location(in: self.view)
        if let selectedCard = whichCard(point){
            if let human = human{
                if (human.isPlayed(selectedCard.tag)){
                    return
                }
            }
            animationCard = selectedCard
            animation(selectedCard, name:"human")
        }
    }
    
    func showPile(){
        for view in closedCards{
            if (view.tag > pile.numberOfCards() + 7){
                view.isHidden = true
            } else {
                view.isHidden = false
            }
        }
        self.view.bringSubview(toFront: middleCard)
    }
    
    func animation(_ card:UIImageView, name:String){
        let animation : CABasicAnimation = CABasicAnimation(keyPath: "position")
        animation.isAdditive = true
        animation.fromValue = NSValue(cgPoint: CGPoint.zero)
        animation.toValue = NSValue(cgPoint:CGPoint(x: middleCard.frame.origin.x - card.frame.origin.x, y: middleCard.frame.origin.y - card.frame.origin.y))
        animation.autoreverses = false
        animation.duration = 1
        animation.repeatCount = 1
        animation.delegate = self
        card.layer.add(animation, forKey:name)
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if let animationCard = animationCard{
            animationCard.isHidden = true
            if (animationCard.tag < 4){
                if let human = human{
                    play(human, stack:humanStack, cardNo:animationCard.tag)
                    computersMove()
                }
            } else {
                animationCard.image = UIImage(named: "bos.png")
                if let computer = computer{
                    play(computer, stack:computerStack, cardNo:animationCard.tag - 4)
                    continueGame()
                }
            }
        }
    }
    
    func play(_ hand : Hand, stack : Stack, cardNo : Int){
        let kart : Card = hand.play(cardNo)
        pile.addCard(kart)
        if (pile.winExists()){
            pile.sendToStack(stack)
            showPile()
            middleCard.image = nil
        } else {
            showPile()
            if let ustKart = pile.topCard(){
                middleCard.image = UIImage(named: ustKart.description() + ".png")
            }
        }
    }
    
    func gameOver(){
        var computerPoints : Int = computerStack.points()
        var humanPoints : Int = humanStack.points()
        if (computerStack.numberOfCards() > humanStack.numberOfCards()){
            computerPoints += 3
        } else {
            humanPoints += 3
        }
        let message : String = String(format:"Computer:%d Human:%d", computerPoints, humanPoints)
        let alarm = UIAlertController(title: "Game Over!", message: message, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
        alarm.addAction(okAction)
        self.present(alarm, animated: true, completion: nil)
    }
    
    func continueGame(){
        moveCount += 1
        if (moveCount == 4){
            moveCount = 0
            numberOfDeals += 1
            if (numberOfDeals < 6){
                dealCards()
                showPile()
            } else {
                gameOver()
            }
        }
    }
    
    func sameCardExists()->Int{
        if let computer = computer{
            if let topCard = pile.topCard(){
                for i in 0...3{
                    if (!computer.isPlayed(i) && computer.getCard(i).value == topCard.value){
                        return i
                    }
                }
            }
        }
        return -1
    }
    
    func jackExists()->Int{
        if let computer = computer{
            for i in 0...3{
                if (!computer.isPlayed(i) && computer.getCard(i).value == 11){
                    return i
                }
            }
        }
        return -1
    }
    
    func playRandom()->Int{
        var card : Int = Int(arc4random_uniform(4))
        if let computer = computer{
            while (computer.isPlayed(card)){
                card = Int(arc4random_uniform(4))
            }
        }
        return card
    }
    
    func computersMove(){
        var selectedCard : Int = -1
        if (pile.topCard() != nil){
            selectedCard = sameCardExists()
            if (selectedCard == -1){
                selectedCard = jackExists()
            }
        }
        if (selectedCard == -1){
            selectedCard = playRandom()
        }
        for view in computerCards{
            if (view.tag == selectedCard + 4){
                if let computer = computer{
                    view.image = UIImage(named: computer.getCard(view.tag - 4).description() + ".png")
                    animationCard = view
                    animation(view, name:"computer")
                    break
                }
            }
        }
    }
    
    func dealCards(){
        human = deck.dealHand()
        computer = deck.dealHand()
        for i in 0...3{
            if let human = human{
                cards[i].image = UIImage(named: human.getCard(cards[i].tag).description() + ".png")
                cards[i].isHidden = false
            }
        }
        if let topCard = pile.topCard(){
            middleCard.image = UIImage(named: topCard.description() + ".png")
        } else {
            middleCard.image = nil
        }
        for view in computerCards{
            view.isHidden = false
        }
        moveCount = 0
    }
    
    func startGame(){
        numberOfDeals = 0
        deck = Deck()
        pile = Pile()
        humanStack = Stack()
        computerStack = Stack()
        deck.dealPile(pile)
        dealCards()
        showPile()
    }
    
    func inTheRegion(_ card : UIImageView, apoint : CGPoint)->Bool{
        if (apoint.x > card.frame.origin.x && apoint.x < card.frame.origin.x + card.frame.size.width &&
            apoint.y > card.frame.origin.y && apoint.y < card.frame.origin.y + card.frame.size.height){
            return true
        } else {
            return false
        }
    }
    
    func whichCard(_ point : CGPoint)->UIImageView?{
        for view in cards{
            if (inTheRegion(view, apoint:point)){
                return view
            }
        }
        return nil
    }
    
}

