//
//  Score.swift
//  Project2
//
//  Created by Alejandro Gleason on 22/05/21.
//

import UIKit

class Score: NSObject, Codable {
    var highestScore: Int
    
    init(newScore: Int) {
        self.highestScore = newScore
    }
}
