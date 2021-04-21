//
//  ViewController.swift
//  Challenge3
//
//  Created by Alejandro Gleason on 20/04/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var usedLettersLabel: UILabel!
    @IBOutlet var lifeLabel: UILabel!
    @IBOutlet var guessButton: UIButton!
    @IBOutlet var wordLabel: UILabel!
    var words = [String]()
    var usedLetters: [String] = [] {
        didSet {
            let stringRepresentation = usedLetters.joined(separator:", ")
            usedLettersLabel.text = "[" +  stringRepresentation + "]"
        }
    }
    var wordToGuess = ""
    var wordToGuessMasked = "" {
        didSet {
            wordLabel.text = wordToGuessMasked
        }
    }
    var attempts = 7 {
        didSet {
            lifeLabel.text = "Remaining attempts: \(attempts)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up initial UI
        title = "HANGMAN"
        guessButton.setTitle("Enter Guess", for: .normal)
        guessButton.addTarget(self, action: #selector(enterGuess), for: .touchUpInside)
        guessButton.layer.cornerRadius = 5
        usedLettersLabel.text = "[ ]"

        lifeLabel.text = "Remaining attempts: \(attempts)"
        
        loadFile("words")
    }
    
    func loadFile(_ name: String) {
        // start background work
        DispatchQueue.global(qos: .background).async { [weak self] in
            if let levelFileURL = Bundle.main.url(forResource: name, withExtension: "txt"){
                if let levelContents = try? String(contentsOf: levelFileURL) {
                    // Iterating through the found words
                    let lines = levelContents.components(separatedBy: "\n")
                    for word in lines {
                        self?.words.append(word)
                    }
                    return
                }
            }
        }
        
        // background work has finished
        DispatchQueue.main.async { [weak self] in
            self?.pickWord()
        }
    }
    
    func pickWord() {
        if let word = words.randomElement() {
            wordToGuess = word
            var mask = ""
            for _ in 0..<word.count {
                mask += "?"
            }
            wordToGuessMasked = mask
            wordLabel.text = wordToGuessMasked
        }
    }
    
    func reloadGame(action: UIAlertAction) {
        pickWord()
        usedLetters = []
        attempts = 7
    }
    
    func removeTry() {
        attempts -= 1
        if attempts <= 0 {
            let ac = UIAlertController(title: "GAME OVER", message: "You did not guessed the word, try again!", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "CONTINUE", style: .default, handler: reloadGame))
            present(ac, animated: true)
            wordToGuessMasked = wordToGuess
        }
    }
    
    @objc func enterGuess() {
        let ac = UIAlertController(title: "New Guess", message: nil, preferredStyle: .alert)
        // Adds a new input text box
        ac.addTextField()
        
        // We will use trailing closure syntax
        let submitAction = UIAlertAction(title: "Ok", style: .default) {
            // weak self refers to the view controller, ac to the alert controller are not captured strongly - avoids memory leaking
            [weak self, weak ac] _ in // remember the 'in' divides between before params (coming in) and after (the things we want to do then the code runs)
            guard let char = ac?.textFields?[0].text else { return }
            self?.guess(char)
        }

        ac.addAction(submitAction)
        present(ac, animated: true)
    }
        
    // function to check for guessed words
    func guess(_ char: String) {
        if !usedLetters.contains(char) {
            usedLetters.append(char)
            if !wordToGuess.contains(char) {
                removeTry()
            } else {
                if wordToGuess.contains(char) {
                    var promptWord = ""
                    var lostFlag = false
                    
                    for letter in wordToGuess {
                        let strLetter = String(letter)
                        
                        if usedLetters.contains(strLetter) {
                            promptWord += strLetter
                        } else {
                            promptWord += "?"
                            lostFlag = true
                        }
                    }
                    wordToGuessMasked = promptWord
                    // they have guessed the word!
                    if !lostFlag {
                        let ac = UIAlertController(title: "YOU GUESSED!", message: "You guessed the word correctly, play again!", preferredStyle: .alert)
                        ac.addAction(UIAlertAction(title: "CONTINUE", style: .default, handler: reloadGame))
                        present(ac, animated: true)
                    }
                }
               
            }
        }
    }

}

