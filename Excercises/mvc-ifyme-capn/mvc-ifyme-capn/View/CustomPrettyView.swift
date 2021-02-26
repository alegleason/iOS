//
//  CustomPrettyView.swift
//  mvc-ifyme-capn
//
//  Created by Alejandro Gleason on 23/02/21.
//

import UIKit

class CustomPrettyView: UIView {
    // Basically we are overriding the function to tell which class a view belongs
    override func awakeFromNib() {
        layer.cornerRadius = 20
        layer.shadowColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        layer.shadowRadius = 10
        layer.shadowOpacity = 0.75
        layer.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        layer.borderWidth = 5
    }
}
