//
//  ViewController.swift
//  Challenge5
//
//  Created by Alejandro Gleason on 08/09/21.
//

import UIKit

class ViewController: UITableViewController {
    var countries = [Country]()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Country Facts"
        
        // Enables large titles across the app
        navigationController?.navigationBar.prefersLargeTitles = true
        
        if let path = Bundle.main.path(forResource: "countries_metadata", ofType: "json") {
            // Converting into a Data object by using its default constructor
            if let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe) {
                // Here it is OK to parse
                parse(json: data)
                return
            }
        }
        
        // If parsing of url or data failed
        showError()
        
    }
    
    func showError() {
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; check your connection.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default))
        present(ac, animated: true)
    }
    
    // Data is any kind of binary data
    func parse(json: Data){
        let decoder = JSONDecoder()
        // decoder.decode first parameter is "what" object type we want to convert the data recieved in the "from" parameter
        if let jsonPetitions = try? decoder.decode(Countries.self, from: json) {
            // Assign the array of results
            countries = jsonPetitions.results
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let country = countries[indexPath.row]
        cell.textLabel?.numberOfLines = 0 // allow the cell to fill up two lines of text by default
        cell.textLabel?.text = country.title
        cell.detailTextLabel?.text = country.capital_city
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Instantiate and push our view controller
        if let vc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController {
            vc.detailItem = countries[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

