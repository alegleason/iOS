//
//  SamsungProduct.swift
//  mvc-ifyme-capn
//
//  Created by Alejandro Gleason on 24/02/21.
//

import Foundation

class SamsungProduct {
    // private(set) means private set, public get
    private(set) var name: String
    private(set) var color: String
    private(set) var price: Double
    
    init(name: String, color: String, price: Double) {
        self.name = name
        self.color = color
        self.price = price
    }
}

