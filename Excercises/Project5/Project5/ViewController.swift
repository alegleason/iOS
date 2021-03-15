//
//  ViewController.swift
//  Project5
//
//  Created by Alejandro Gleason on 04/03/21.
//

import UIKit

class ViewController: UITableViewController {
    var allWords = [String]()
    var usedWords = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // remember closures are chunks of words that can be treated as variables
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        
        // Add a Bar Button to look at the current score
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(startGame))
        
        // Load the resource (file)
        if let startWorldsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            // Unwrap the content as a string
            if let startWords = try? String(contentsOf: startWorldsURL) {
                allWords = startWords.components(separatedBy: "\n")
            }
        }
        
        if allWords.isEmpty {
            allWords = ["silkworm"]
        }
        // The objective of the game is to create new words using all or some of the letters of the given word
        startGame()
    }
    
    @objc
    func startGame() {
        title = allWords.randomElement()
        usedWords.removeAll(keepingCapacity: true)
        // reloadData() reloads all rows and sections, "rebuilding" the table and calling all their methods again
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }
    
    @objc func promptForAnswer() {
        let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        // Adds a new input text box
        ac.addTextField()
        
        // We will use trailing closure syntax
        let submitAction = UIAlertAction(title: "Submit", style: .default) {
            // weak self refers to the view controller, ac to the alert controller are not captured strongly - avoids memory leaking
            [weak self, weak ac] _ in // remember the 'in' divides between before params (coming in) and after (the things we want to do then the code runs)
            guard let answer = ac?.textFields?[0].text else { return }
            self?.submit(answer)
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
        
    }
    
    func submit(_ answer: String) {
        let lowerAnswer = answer.lowercased()
        
        if isPossible(word: lowerAnswer) {
            if isOriginal(word: lowerAnswer) {
                if isReal(word: lowerAnswer) {
                    usedWords.insert(answer, at: 0)
                    let indexPath = IndexPath(row: 0, section: 0)
                    // .automatic performs the "standard" animation
                    tableView.insertRows(at: [indexPath], with: .automatic)
                    return
                } else {
                    showErrorMessage(errorTitle: "Word not recognized", errorMessage: "You can't just make them up, you know!")
                }
            } else {
                showErrorMessage(errorTitle: "Word already used", errorMessage: "Be more original")
            }
        } else {
            showErrorMessage(errorTitle: "Word not possible", errorMessage: "You cannot spell that word from \(title!.lowercased())")
        }
    }
    
    func showErrorMessage(errorTitle: String, errorMessage: String) {
        let ac = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    // Check if the word can be created or not from the input word
    func isPossible(word: String) -> Bool {
        // Retrieve the word to guess from the title
        guard var tempWord = title?.lowercased() else { return false }
        for letter in word {
            // If the letter exist, remove it to 'shrink' it and continue iterating
            if let position = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: position)
            } else {
                return false
            }
        }
        return true
    }
    
    // Determine if the entered word is a word that has already been guessed
    func isOriginal(word: String) -> Bool {
        if !usedWords.contains(where: {$0.caseInsensitiveCompare(word) == .orderedSame}) && word != title {
            return true
        } else {
            return false
        }
    }
    
    // Literally, determine if the word is contained on the english dictionary
    func isReal(word: String) -> Bool {
        if word.count < 3 {
            return false
        }
        // UI Kit to check for text related stuff
        let checker = UITextChecker()
        // UI Text Checker is not good with swift, it likes to have the utf16 (@objc) type
        let range = NSRange(location: 0, length: word.utf16.count)
        // wrap lets us set whether the UITextChecker should start at the beginning of the range if no misspelled words were found starting from parameter three
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }

}

