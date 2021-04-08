//
//  Petition.swift
//  Project7
//
//  Created by Alejandro Gleason on 20/03/21.
//

import Foundation

// Adding Codable makes it decodable for JSON
struct Petition: Codable {
    // We will define our own struct to manage data, which will conform to Codable protocol
    var title: String
    var body: String
    var signatureCount: Int
    
}


