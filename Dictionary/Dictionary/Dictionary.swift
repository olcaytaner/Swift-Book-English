//
//  ViewController.swift
//  Sozluk
//
//  Created by Olcay Taner YILDIZ on 1/21/15.
//  Copyright (c) 2015 Olcay Taner YILDIZ. All rights reserved.
//

import UIKit

class Dictionary : NSObject, XMLParserDelegate{
    fileprivate var words : [DictionaryWord] = []
    fileprivate var parser : XMLParser
    fileprivate var word : DictionaryWord?
    fileprivate var meaningClass : String = ""
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
    
    func searchWord(_ wordToBeSearched : String)->[DictionaryWord]{
        var resultList : [DictionaryWord] = []
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
            word = DictionaryWord(literal: literal)
            value = ""
            if let meaningClass: AnyObject = attributeDict["lex_class"] as AnyObject?{
                if let word = word{
                    word.meaningClass = String(meaningClass as! NSString)
                }
            }
            if let origin: AnyObject = attributeDict["origin"] as AnyObject?{
                if let word = word{
                    word.origin = String(origin as! NSString)
                }
            }
        } else {
            if (elementName == "meaning") {
                if let lexclass:AnyObject = attributeDict["class"] as AnyObject?{
                    meaningClass = String(lexclass as! NSString)
                }
                value = ""
            }
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String){
        value = value + string
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?){
        var meaning : Meaning
        if (elementName == "lexicon"){
            return
        } else {
            if (elementName == "word"){
                words.append(word!)
            } else {
                if (elementName == "meaning"){
                    if (!meaningClass.isEmpty){
                        meaning = Meaning(lexicalClass: meaningClass, meaning:value)
                    } else {
                        meaning = Meaning(meaning: value)
                    }
                    if let word = word{
                        word.addMeaning(meaning)
                    }
                }
            }
        }
    }

}

