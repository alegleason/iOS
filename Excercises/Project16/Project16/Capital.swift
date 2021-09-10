//
//  Capital.swift
//  Project16
//
//  Created by Alejandro Gleason on 09/09/21.
//

import MapKit
import UIKit

class Capital: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String
    var wikiPage: URL!
    
    init(title: String, coordinate: CLLocationCoordinate2D, info: String, wikiPage: URL) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
        self.wikiPage = wikiPage
    }

}
