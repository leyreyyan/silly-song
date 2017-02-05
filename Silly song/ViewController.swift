//
//  ViewController.swift
//  Silly song
//
//  Created by Stephane Moreau on 04/02/2017.
//  Copyright © 2017 Stephane Moreau. All rights reserved.
//

import UIKit

func shortNameFromName(name: String) -> String {
    let vowelCharacterset = CharacterSet.init(charactersIn: "aeiou")
    var name = name.lowercased().folding(options: String.CompareOptions.diacriticInsensitive, locale: NSLocale.current)
    let range = name.startIndex..<name.index(after: name.startIndex)
    while ((name.rangeOfCharacter(from: vowelCharacterset, options: String.CompareOptions.diacriticInsensitive, range: range)) == nil) {
        name = name.substring(from: name.index(after: name.startIndex))
    }
    return name
}

let bananaFanaTemplate = [
    "<FULL_NAME>, <FULL_NAME>, Bo B<SHORT_NAME>",
    "Banana Fana Fo F<SHORT_NAME>",
    "Me My Mo M<SHORT_NAME>",
    "<FULL_NAME>"].joined(separator: "\n")


func lyricsForName(lyricsTemplate: String, fullName: String) -> String {
    let sillySong = lyricsTemplate.replacingOccurrences(of: "<FULL_NAME>", with: fullName).replacingOccurrences(of: "<SHORT_NAME>", with: shortNameFromName(name: fullName))
    return sillySong
}

// MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}


class ViewController: UIViewController {

    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var lyricsView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        nameField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func reset(_ sender: Any) {
        nameField.text = ""
        lyricsView.text = ""
    }
    @IBAction func displayLyrics(_ sender: Any) {
        if nameField.text != "" {
            let lyrics = lyricsForName(lyricsTemplate: bananaFanaTemplate, fullName: nameField.text!)
            lyricsView.text = lyrics
        }
    }
}

