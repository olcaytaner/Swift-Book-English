//
//  Cozum.swift
//  SatrancTaslari
//
//  Created by Olcay Taner YILDIZ on 1/18/15.
//  Copyright (c) 2015 Olcay Taner YILDIZ. All rights reserved.
//

class Solution{
    fileprivate var pieces : [Piece] = []
    let allPieces : [Piece] = [Piece(name: "king"), Piece(name: "queen"), Piece(name: "rook1"), Piece(name: "rook2"), Piece(name: "bishop1"), Piece(name: "bishop2"), Piece(name: "knight1"), Piece(name: "knight2")]
    
    func pieceName(_ position : Int)->String{
        if (position >= 0 && position < pieces.count){
            return pieces[position].name
        }else{
            return "empty"
        }
    }
    
    func pieceNo(_ pozisyon : Int)->Int{
        for i in 0..<allPieces.count{
            if (pieces[pozisyon].name == allPieces[i].name){
                return i
            }
        }
        return -1
    }
    
    func numberOfPieces()->Int{
        return pieces.count
    }
    
    func addPiece(_ piece : Piece){
        pieces.append(piece)
    }
    
    func addWithPieceNo(_ pieceNo : Int){
        if (pieceNo >= 0 && pieceNo < 8){
            pieces.append(allPieces[pieceNo])
        }
    }
    
    func removePiece(){
        pieces.removeLast()
    }
    
    func generateCandidates()->[Piece]{
        var found : Bool
        var candidates : [Piece] = []
        for possiblePiece in allPieces{
            found = false
            for piece in pieces{
                if (piece.name == possiblePiece.name){
                    found = true
                    break
                }
            }
            if (!found){
                candidates.append(possiblePiece)
            }
        }
        return candidates
    }

}
