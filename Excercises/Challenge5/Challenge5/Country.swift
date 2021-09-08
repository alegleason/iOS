//
//  Country.swift
//  Challenge5
//
//  Created by Alejandro Gleason on 08/09/21.
//

import Foundation

struct Country: Codable {
    // Fields we want from the json file
    var title: String
    var capital_city: String
    var size: Int
    var population: Int
    var currency: String
}
