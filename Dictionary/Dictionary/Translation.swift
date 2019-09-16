//
//  Ceviri.swift
//  Sozluk
//
//  Created by Olcay Taner YILDIZ on 1/22/15.
//  Copyright (c) 2015 Olcay Taner YILDIZ. All rights reserved.
//

class Translation{
    var lexicalClass : String = ""
    var meaning : Meaning
    
    init(lexicalClass : String, meaning : Meaning){
        self.lexicalClass = lexicalClass
        self.meaning = meaning
    }
    
    init(meaning : Meaning){
        self.meaning = meaning
    }
}
