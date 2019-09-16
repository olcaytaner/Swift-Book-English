//
//  Anlam.swift
//  Sozluk
//
//  Created by Olcay Taner YILDIZ on 1/22/15.
//  Copyright (c) 2015 Olcay Taner YILDIZ. All rights reserved.
//

class Meaning{
    var lexicalClass : String = ""
    var meaning : String = ""
    
    init(lexicalClass : String, meaning : String){
        self.lexicalClass = lexicalClass
        self.meaning = meaning
    }
    
    init(meaning : String){
        self.meaning = meaning
    }
}
