//
//  SozlukEkran.swift
//  Sozluk
//
//  Created by Olcay Taner YILDIZ on 1/22/15.
//  Copyright (c) 2015 Olcay Taner YILDIZ. All rights reserved.
//

import UIKit

class DictionaryScreen : UITableViewController, UISearchBarDelegate, UISearchDisplayDelegate{
    fileprivate var dictionary : Dictionary?
    fileprivate var dictionaryWords : [DictionaryWord] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dictionary = Dictionary(file: "turkish-dictionary")
    }

    func searchDisplayController(_ controller: UISearchDisplayController,shouldReloadTableForSearch searchString: String?)->Bool{
        if let dictionary = dictionary{
            dictionaryWords = dictionary.searchWord(searchString!)
        }
        return true
    }
    
    func searchDisplayController(_ controller: UISearchDisplayController, shouldReloadTableForSearchScope searchOption: Int) -> Bool{
        if let dictionary = dictionary{
            dictionaryWords = dictionary.searchWord(self.searchDisplayController!.searchBar.text!)
        }
        return true
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if tableView == self.searchDisplayController!.searchResultsTableView {
            return dictionaryWords[section].numberOfMeanings()
        } else {
            return 0
        }
    }
    
    override func numberOfSections(in tableView: UITableView?)-> Int{
        return dictionaryWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        var meaning : Meaning
        var dictionaryWord : DictionaryWord
        var meaningInfo, origin : NSMutableAttributedString
        var meaningLabel : UITextView
        let CellIdentifier = "DictionaryCell"
        var cell : UITableViewCell
        cell = self.tableView.dequeueReusableCell(withIdentifier: CellIdentifier)! as UITableViewCell
        dictionaryWord = dictionaryWords[(indexPath as NSIndexPath).section]
        meaning = dictionaryWord.meaning((indexPath as NSIndexPath).row)
        if (!dictionaryWord.meaningClass.isEmpty){
            meaningInfo = NSMutableAttributedString(string: dictionaryWord.meaningClass)
            meaningInfo.append(NSAttributedString(string: ". "))
            meaningInfo.addAttribute(NSForegroundColorAttributeName, value: UIColor.red, range: NSMakeRange(0, meaningInfo.length))
        } else {
            meaningInfo = NSMutableAttributedString(string: "")
        }
        if (!dictionaryWord.origin.isEmpty){
            origin = NSMutableAttributedString(string: dictionaryWord.origin)
            origin.append(NSAttributedString(string: ". "))
            meaningInfo.append(NSAttributedString(attributedString: origin))
            meaningInfo.addAttribute(NSForegroundColorAttributeName, value: UIColor.blue, range: NSMakeRange(meaningInfo.length - origin.length, origin.length))
        }
        meaningInfo.append(NSAttributedString(string: meaning.meaning))
        meaningLabel = cell.viewWithTag(1) as! UITextView
        meaningLabel.attributedText = meaningInfo
        return cell
    }

}
