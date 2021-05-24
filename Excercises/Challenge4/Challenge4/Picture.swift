//
//  Picture.swift
//  Challenge4
//
//  Created by Alejandro Gleason on 24/05/21.
//

import UIKit

class Picture: NSObject, Codable {
    var fileName: String
    var caption: String
    var imgPath: URL
    
    init(name: String, caption: String, path: URL) {
        self.fileName = name
        self.caption = caption
        self.imgPath = path
    }
}
