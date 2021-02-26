//
//  CustomLabelView.swift
//  mvc-ifyme-capn
//
//  Created by Alejandro Gleason on 24/02/21.
//

import UIKit

class CustomLabelView: UILabel {
    override func awakeFromNib() {
        self.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.clipsToBounds = true
        self.font = UIFont(name: "Avenir", size: 22)
        self.sizeToFit()
    }
}
