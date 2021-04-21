//
//  ViewController.swift
//  Project7
//
//  Created by Alejandro Gleason on 20/03/21.
//

import UIKit

class ViewController: UITableViewController {
    var originalPetitions = [Petition]()
    var filteredPetitions = [Petition]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let urlString: String
        
        if navigationController?.tabBarItem.tag == 0 {
            // urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            // urlString = "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=10000&limit=100"
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
        performSelector(inBackground: #selector(fetchJSON), with: urlString)
            
        // alert that shows the users where data comes from
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "help")!.withRenderingMode(.alwaysOriginal), style: UIBarButtonItem.Style.plain, target: self, action: #selector(showCredits))
        
        // action that lets users filter content
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(showFilter))
        
        
    }
    
    @objc func fetchJSON(_ urlString: String) {
        // passing to a background thread, the UI will no longer freeze while parsing the data
//        DispatchQueue.global(qos: .userInitiated).async {
            // this is how we pass the "self" reference to the closure
//            [weak self] in
            if let url = URL(string: urlString) {
                // Converting into a Data object by using its default constructor
                if let data = try? Data(contentsOf: url) {
                    // Here it is OK to parse
//                    self?.parse(json: data)
                    parse(json: data)
                    return
                }
            }
            // If parsing of url or data failed
        performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
//            self?.showError()
//        }
    }
    
    @objc
    func showError() {
        DispatchQueue.main.async { [weak self] in
            let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; check your connection.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default))
            self?.present(ac, animated: true)
        }
    }
    
    @objc
    func showCredits() {
        let ac = UIAlertController(title: "Credits", message: "Data comes from the We The People API of the Whitehouse", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    @objc
    func showFilter() {
        let ac = UIAlertController(title: "Filter", message: nil, preferredStyle: .alert)
        // Adds a new input text box
        ac.addTextField()
        
        // We will use trailing closure syntax
        let submitAction = UIAlertAction(title: "Ok", style: .default) {
            // weak self refers to the view controller, ac to the alert controller are not captured strongly - avoids memory leaking
            [weak self, weak ac] _ in // remember the 'in' divides between before params (coming in) and after (the things we want to do then the code runs)
            guard let words = ac?.textFields?[0].text else { return }
            self?.filter(words)
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    // function to filter
    func filter(_ words: String) {
        
        var temporalPetitions = [Petition]()
        for petition in originalPetitions {
            // case insensitive search
            if let _ = petition.body.range(of: words, options: .caseInsensitive) {
                if let _ = petition.title.range(of: words, options: .caseInsensitive) {
                    temporalPetitions.append(petition)
                }
            }
        }
        
        filteredPetitions = temporalPetitions
        tableView.reloadData()
    }
    
    // Data is any kind of binary data
    func parse(json: Data){
        let decoder = JSONDecoder()
        // decoder.decode first parameter is "what" object type we want to convert the data recieved in the "from" parameter
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            // Assign the array of results
            originalPetitions = jsonPetitions.results
            filteredPetitions = originalPetitions
            // Dispatching back the work to the main thread
//            DispatchQueue.main.async { [weak self] in
//                self?.tableView.reloadData()
//            }
            tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
        } else {
            performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPetitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = filteredPetitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Instantiate and push our view controller
        let vc = DetailViewController()
        vc.detailItem = filteredPetitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }

}

