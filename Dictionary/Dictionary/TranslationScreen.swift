//
//  CeviriEkran.swift
//  Sozluk
//
//  Created by Olcay Taner YILDIZ on 1/22/15.
//  Copyright (c) 2015 Olcay Taner YILDIZ. All rights reserved.
//

import UIKit

class TranslationScreen : UITableViewController, UISearchBarDelegate, UISearchDisplayDelegate{
    fileprivate var translationDictionary : TranslationDictionary?
    fileprivate var translationWords : [SourceWord] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        translationDictionary = TranslationDictionary(file: "english-turkish")
    }
    
    func searchDisplayController(_ controller: UISearchDisplayController,shouldReloadTableForSearch searchString: String?)->Bool{
        if let translationDictionary = translationDictionary{
            translationWords = translationDictionary.searchWord(searchString!)
        }
        return true
    }
    
    func searchDisplayController(_ controller: UISearchDisplayController, shouldReloadTableForSearchScope searchOption: Int) -> Bool{
        if let translationDictionary = translationDictionary{
            translationWords = translationDictionary.searchWord(self.searchDisplayController!.searchBar.text!)
        }
        return true
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if tableView == self.searchDisplayController!.searchResultsTableView {
            return translationWords[section].numberOfTranslations()
        } else {
            return 0
        }
    }
    
    override func numberOfSections(in tableView: UITableView?)-> Int{
        return translationWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        var meaning : Meaning
        var translation : Translation
        var sourceWord : SourceWord
        var meaningInfo: NSMutableAttributedString
        var meaningLabel : UITextView
        let CellIdentifier = "TranslationCell"
        var cell : UITableViewCell
        cell = self.tableView.dequeueReusableCell(withIdentifier: CellIdentifier)! as UITableViewCell
        sourceWord = translationWords[(indexPath as NSIndexPath).section]
        translation = sourceWord.translation((indexPath as NSIndexPath).row)
        meaning = translation.meaning
        if (!translation.lexicalClass.isEmpty){
            meaningInfo = NSMutableAttributedString(string: translation.lexicalClass)
            meaningInfo.append(NSAttributedString(string: ". "))
            meaningInfo.addAttribute(NSForegroundColorAttributeName, value: UIColor.red, range: NSMakeRange(0, meaningInfo.length))
            meaningInfo.append(NSAttributedString(string: meaning.meaning))
        } else {
            meaningInfo = NSMutableAttributedString(string: meaning.meaning)
        }
        meaningLabel = cell.viewWithTag(1) as! UITextView
        meaningLabel.attributedText = meaningInfo
        return cell
    }

}
