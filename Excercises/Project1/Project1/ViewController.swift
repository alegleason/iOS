//
//  ViewController.swift
//  Project1
//
//  Created by Alejandro Gleason on 20/02/21.
//

import UIKit

class ViewController: UITableViewController {
    public var pictures = [String]()

    // Called when the screen has loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        
        // Enables large titles across the app
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath
        let items = try? fm.contentsOfDirectory(atPath: path!)
        
        if let its = items {
            for it in its {
                if it.hasPrefix("nssl") {
                    pictures.append(it)
                }
            }
        } else {
            print("Error at opening files!")
        }
        pictures = pictures.sorted()
        //print(pictures.sorted())
    }
    
    // Overriding how the header should look like
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let myLabel = UILabel()
        myLabel.frame = CGRect(x: 20, y: 8, width: 320, height: 20)
        myLabel.font = UIFont(name:"Avenir", size:24)
        myLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
        let headerView = UIView()
        headerView.addSubview(myLabel)
        return headerView
    }
    
    // Overriding the behavior of how many rows are shown
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // We only override this part
        return pictures.count
    }
    
    // Overriding how each row looks like
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Recycling cells (object pool?)
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.font = UIFont(name:"Avenir", size:20)
        // Index path contains both a section number and a row number, here, we only care about the row number
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }
    
    // Override what should happen when a row is selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // This is how you instanciate a personalized view controller
        if let vc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController {
            // Pushing parameters
            vc.selectedImage = pictures[indexPath.row]
            DetailViewController.totalImages = pictures.count
            vc.currentImage = indexPath.row + 1
            // Pushing and showing the detail view controller
            navigationController?.pushViewController(vc, animated: true)
        }
    }
   
}

