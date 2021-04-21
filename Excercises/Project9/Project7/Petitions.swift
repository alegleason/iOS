//
//  Petitions.swift
//  Project7
//
//  Created by Alejandro Gleason on 20/03/21.
//

import Foundation

// Here we will indicate exactly where is the data
struct Petitions: Codable {
    // We state what field of the JSON to look on, it must match the json data
    var results: [Petition]
}
