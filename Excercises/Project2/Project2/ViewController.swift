//
//  ViewController.swift
//  Project2
//
//  Created by Alejandro Gleason on 23/02/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var Button1: UIButton!
    @IBOutlet var Button2: UIButton!
    @IBOutlet var Button3: UIButton!
    
    var countries = [String]()
    var score = Score(newScore: 0)
    var correctAnswer = 0
    var questionsAsked = 5
    var highestScore = Score(newScore: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        // Add a Bar Button to look at the current score
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(scoreTapped))
        
        // Adding borders to the buttons
        Button1.layer.borderWidth = 1
        Button2.layer.borderWidth = 1
        Button3.layer.borderWidth = 1
        
        // Modyfing border colors
        Button1.layer.borderColor = UIColor.lightGray.cgColor
        Button2.layer.borderColor = UIColor.lightGray.cgColor
        Button3.layer.borderColor = UIColor.lightGray.cgColor
        
        let defaults = UserDefaults.standard
        
        // Retrieve the saved people array
        if let savedScore = defaults.object(forKey: "highestScore") as? Data {
            // Unpack it as json object
            let jsonDecoder = JSONDecoder()
            // We are going to use a try catch statement for errors
            
            do {
                highestScore = try jsonDecoder.decode(Score.self, from: savedScore)
            } catch {
                print("Failed to load score.")
            }
        }
                
        askQuestion()
    }
    
    func askQuestion(action: UIAlertAction! = nil) {
        questionsAsked -= 1
        if questionsAsked < 0 {
            finishGame()
        }
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        // for .normal means we are changing the "standard" state of the UIButton
        Button1.setImage(UIImage(named: countries[0]), for: .normal)
        Button2.setImage(UIImage(named: countries[1]), for: .normal)
        Button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = "\(countries[correctAnswer].uppercased()) - Score: \(score.highestScore)"
        
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        let message: String
        
        sender.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)

        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [], animations: {
            sender.transform = .identity
        }, completion: nil)
        
        if sender.tag == correctAnswer {
            title = "Correct"
            message = "That is \(countries[correctAnswer]) flag"
            score.highestScore += 1
        } else {
            title = "Incorrect"
            message = "That is \(countries[sender.tag]) flag"
            score.highestScore -= 1
        }
        
        // preferredStyle could have also recieved .actionsheet, which is good for the user to pick from a set of options, while .alert for telling user situation change
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        // It adds a button to the alert and when closed, we tell it to call our askQuestion() method again
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        
        present(ac, animated: true)
    }
    
    func finishGame() {
        // preferredStyle could have also recieved .actionsheet, which is good for the user to pick from a set of options, while .alert for telling user situation change
        let ac = UIAlertController(title: "Game end!", message: "Your score was \(score.highestScore) / 5", preferredStyle: .alert)
        
        if (score.highestScore > highestScore.highestScore) {
            highestScore.highestScore = score.highestScore
            print("New highest score: \(highestScore.highestScore)")
            save()
        }
        
        // It adds a button to the alert and when closed, we tell it to call our askQuestion() method again
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        
        present(ac, animated: true)
        
        // Re init the game counters
        score.highestScore = 0
        correctAnswer = 0
        questionsAsked = 5
    }
    
    // Action response to show current score
    @objc func scoreTapped() {
        // preferredStyle could have also recieved .actionsheet, which is good for the user to pick from a set of options, while .alert for telling user situation change
        let ac = UIAlertController(title: "SCORE", message: "Your current score is \(score)", preferredStyle: .alert)
        
        // It adds a button to the alert and when closed, we tell it to call our askQuestion() method again
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
        
        present(ac, animated: true)
    }
    
    func save(){
        let jsonEncoder = JSONEncoder()
        
        if let savedData = try? jsonEncoder.encode(highestScore) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "highestScore")
        } else {
            print("Failed to save new score.")
        }
    }
}
