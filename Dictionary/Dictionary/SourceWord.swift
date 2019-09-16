//
//  KaynakKelime.swift
//  Sozluk
//
//  Created by Olcay Taner YILDIZ on 1/22/15.
//  Copyright (c) 2015 Olcay Taner YILDIZ. All rights reserved.
//

class SourceWord : Word{
    fileprivate var translations : [Translation] = []
    
    override init(literal :String){
        super.init(literal: literal)
    }
    
    func addTranslation(_ translation : Translation){
        translations.append(translation)
    }
    
    func numberOfTranslations()->Int{
        return translations.count
    }
    
    func translation(_ position : Int)->Translation{
        return translations[position]
    }
}
