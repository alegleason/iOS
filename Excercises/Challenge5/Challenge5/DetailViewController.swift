//
//  DetailViewController.swift
//  Challenge5
//
//  Created by Alejandro Gleason on 08/09/21.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var capital: UILabel!
    @IBOutlet var size: UILabel!
    @IBOutlet var currency: UILabel!
    @IBOutlet var population: UILabel!
    // Optional vars to pass to the "constructor"
    var detailItem: Country?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let country = detailItem else { return }
        
        title = country.title
        capital.text = "Capital City: \(country.capital_city)"
        size.text = "Size: \(country.size)"
        currency.text = "Currency: \(country.currency)"
        population.text = "Population: \(country.population)"
    }
    
}
