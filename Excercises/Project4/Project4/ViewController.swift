//
//  ViewController.swift
//  Project4
//
//  Created by Alejandro Gleason on 02/03/21.
//

import UIKit
import WebKit

class ViewController: UITableViewController, WKNavigationDelegate {
    var websites = ["gleason-portafolio.herokuapp.com", "fragrantica.es", "apple.com", "twitter.com"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Render the initial table
        title = "Web Browser"
        // Enables large titles across the app
        navigationController?.navigationBar.prefersLargeTitles = true
    }
        
    // Overriding the behavior of how many rows are shown
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // We only override this part
        print(websites.count)
        return websites.count
    }
    
    // Overriding how each row looks like
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Recycling cells (object pool?)
        let cell = tableView.dequeueReusableCell(withIdentifier: "Website", for: indexPath)
        cell.textLabel?.font = UIFont(name:"Avenir", size:20)
        // Index path contains both a section number and a row number, here, we only care about the row number
        cell.textLabel?.text = websites[indexPath.row]
        return cell
    }

    // Override what should happen when a row is selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // This is how you instanciate a personalized view controller
        if let vc = storyboard?.instantiateViewController(identifier: "Webview") as? WebViewController {
            // Pushing parameters
            vc.selectedWebsite = websites[indexPath.row]
            // Pushing and showing the detail view controller
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

