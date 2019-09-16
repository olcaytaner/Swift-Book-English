//
//  CeviriSozluk.swift
//  Sozluk
//
//  Created by Olcay Taner YILDIZ on 1/22/15.
//  Copyright (c) 2015 Olcay Taner YILDIZ. All rights reserved.
//

import UIKit

class TranslationDictionary : NSObject, XMLParserDelegate{
    fileprivate var words : [SourceWord] = []
    fileprivate var parser : XMLParser
    fileprivate var word : SourceWord?
    fileprivate var meaningClass : String = ""
    fileprivate var translationClass : String = ""
    fileprivate var value : String = ""
    
    init (file : String){
        var fileContents : Data
        var fileName : String
        fileName = Bundle.main.path(forResource: file, ofType: "xml")!
        fileContents = try! Data(contentsOf: URL(fileURLWithPath: fileName))
        parser = XMLParser(data: fileContents)
        super.init()
        parser.delegate = self
        parser.parse()
    }
    
    func searchWord(_ wordToBeSearched : String)->[SourceWord]{
        var resultList : [SourceWord] = []
        for word in words{
            if (word.literal == wordToBeSearched){
                resultList.append(word)
            }
        }
        return resultList
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        var literal : String
        if (elementName == "word"){
            literal = attributeDict["name"]! as String
            word = SourceWord(literal: literal)
            translationClass = ""
            value = ""
        } else {
            if (elementName == "lexical") {
                translationClass = attributeDict["class"]! as String
                value = ""
            } else {
                if (elementName == "meaning"){
                    if let lexclass:AnyObject = attributeDict["class"] as AnyObject?{
                        meaningClass = String(lexclass as! NSString)
                    }
                    value = ""
                }
            }
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String){
        value = value + string
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?){
        var meaning : Meaning
        var translation : Translation
        if (elementName == "lexicon"){
            return
        } else {
            if (elementName == "word"){
                words.append(word!)
            } else {
                if (elementName == "lexical"){
                    translationClass = ""
                } else {
                    if (elementName == "meaning"){
                        if (!meaningClass.isEmpty){
                            meaning = Meaning(lexicalClass: meaningClass, meaning:value)
                        } else {
                            meaning = Meaning(meaning: value)
                        }
                        if (!translationClass.isEmpty){
                            translation = Translation(lexicalClass: translationClass, meaning:meaning)
                        } else {
                            translation = Translation(meaning : meaning)
                        }
                        if let word = word{
                            word.addTranslation(translation)
                        }
                    }
                }
            }
        }
    }
}

