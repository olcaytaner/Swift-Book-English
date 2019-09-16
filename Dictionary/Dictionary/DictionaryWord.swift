//
//  SozlukKelime.swift
//  Sozluk
//
//  Created by Olcay Taner YILDIZ on 1/22/15.
//  Copyright (c) 2015 Olcay Taner YILDIZ. All rights reserved.
//

class DictionaryWord: Word{
    var meaningClass : String = ""
    var origin : String = ""
    fileprivate var meanings : [Meaning] = []
    
    override init(literal : String){
        super.init(literal: literal)
    }
    
    func addMeaning(_ meaning : Meaning){
        meanings.append(meaning)
    }
    
    func numberOfMeanings()->Int{
        return meanings.count
    }
    
    func meaning(_ position : Int)->Meaning{
        return meanings[position]
    }
}
