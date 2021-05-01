//
//  Person.swift
//  Project10
//
//  Created by Alejandro Gleason on 30/04/21.
//

import UIKit

// NSObject is the base class of every Coca Touch Class
class Person: NSObject {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
