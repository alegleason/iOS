//
//  Person.swift
//  Project10
//
//  Created by Alejandro Gleason on 30/04/21.
//

import UIKit

// NSObject is the base class of every Coca Touch Class
class Person: NSObject, NSCoding {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
    
    required init?(coder aDecoder: NSCoder) {
        // This required init will try to decode whatever was presaved
        name = aDecoder.decodeObject(forKey: "name") as? String ?? ""
        image = aDecoder.decodeObject(forKey: "image") as? String ?? ""
    }
    
    // Function to encode name and image properties of each person
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "named")
        aCoder.encode(image, forKey: "image")
    }
}
