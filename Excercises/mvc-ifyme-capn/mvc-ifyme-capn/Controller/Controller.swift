//
//  Controller.swift
//  mvc-ifyme-capn
//
//  Created by Alejandro Gleason on 23/02/21.
//

import UIKit

class Controller: UIViewController {
    //@IBOutlet strong var iphoneNameLabel: UILabel!
    @IBOutlet var iphoneNameLabel: UILabel!
    @IBOutlet var iphoneColorLabel: UILabel!
    @IBOutlet var iphonePriceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //let appleProduct = AppleProduct(name: "iPhone 12 Pro Max", color: "Navy Blue", price: 999.00)
        let samsungProduct = SamsungProduct(name: "Samsung S9", color: "Space Grey", price: 899.99)
        
        iphoneNameLabel.text = samsungProduct.name
        iphoneColorLabel.text = "in \(samsungProduct.color)"
        iphonePriceLabel.text = "$\(samsungProduct.price)"
        
        let newLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 400, height: 20))
        newLabel.center = CGPoint(x: self.view.frame.maxX/2, y: self.view.frame.maxY - 200)
        newLabel.textAlignment = .center
        newLabel.text = "Apple or Samsung? Apple ofc!"
        self.view.addSubview(newLabel)
    }


}

