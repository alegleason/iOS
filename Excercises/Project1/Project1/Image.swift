//
//  Image.swift
//  Project1
//
//  Created by Alejandro Gleason on 22/05/21.
//

import UIKit

// NSObject is the base class of every Coca Touch Class
class Image: NSObject, Codable, Comparable {
    var timesShown: Int
    var imageName: String
    
    init(times: Int, name: String) {
        self.timesShown = times
        self.imageName = name
    }
}

func < (lhs: Image, rhs: Image) -> Bool {
    return lhs.imageName < rhs.imageName
}

func == (lhs: Image, rhs: Image) -> Bool {
    return lhs.imageName == rhs.imageName
}
