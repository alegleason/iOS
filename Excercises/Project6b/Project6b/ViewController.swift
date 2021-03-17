//
//  ViewController.swift
//  Project6b
//
//  Created by Alejandro Gleason on 16/03/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let label1 = UILabel()
        // Ignore default iOS Auto Layout constraints
        label1.translatesAutoresizingMaskIntoConstraints = false
        label1.backgroundColor = .red
        label1.text = "THESE"
        // Take just the required space, no more
        label1.sizeToFit()
        
        let label2 = UILabel()
        label2.translatesAutoresizingMaskIntoConstraints = false
        label2.backgroundColor = .cyan
        label2.text = "ARE"
        label2.sizeToFit()
    
        let label3 = UILabel()
        label3.translatesAutoresizingMaskIntoConstraints = false
        label3.backgroundColor = .yellow
        label3.text = "SOME"
        label3.sizeToFit()
        
        let label4 = UILabel()
        label4.translatesAutoresizingMaskIntoConstraints = false
        label4.backgroundColor = .green
        label4.text = "AWESOME"
        label4.sizeToFit()
        
        let label5 = UILabel()
        label5.translatesAutoresizingMaskIntoConstraints = false
        label5.backgroundColor = .orange
        label5.text = "LABELS"
        label5.sizeToFit()
        
        // Add the labels to the current screen
        view.addSubview(label1)
        view.addSubview(label2)
        view.addSubview(label3)
        view.addSubview(label4)
        view.addSubview(label5)
        
        let viewsDictionary = ["label1": label1, "label2": label2, "label3": label3, "label4": label4, "label5": label5]

//        // Adding the constraints dictionary to the view
//        for label in viewsDictionary.keys {
//            view.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: "H:|[\(label)]|", options: [], metrics: nil, views: viewsDictionary))
//        }
//
//        let metrics = ["labelHeight": 88]
//
//        // The first parameter can take a H as in "H:...", which means that we would be adding a horizontanl layout, V for vertical
//        view.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: "V:|[label1(labelHeight@999)]-[label2(label1)]-[label3(label1)]-[label4(label1)]-[label5(label1)]->=10-|", options: [], metrics: metrics, views: viewsDictionary))
        
        var previous: UILabel?

        for label in [label1, label2, label3, label4, label5] {
            // This lets us use the safe area (both top, bottom, left and right) area in an effective way
            let guide = view.safeAreaLayoutGuide
            label.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
            label.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
            // When you use both a multiplier and a constant, the multiplier gets factored in first then the constant. Here we are are saying that each label should measure aprox. 1/6 of the safe area height, minus 10.
            label.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.15, constant: -10).isActive = true

            if let previous = previous {
                // we have a previous label – create a height constraint
                label.topAnchor.constraint(equalTo: previous.bottomAnchor, constant: 10).isActive = true
            } else {
                // If we are with the top label, position it just below our safe area
                label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
            }

            // set the previous label to be the current one, for the next loop iteration
            previous = label
        }
        
        
    }


}

