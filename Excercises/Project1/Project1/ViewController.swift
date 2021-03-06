//
//  ViewController.swift
//  Project1
//
//  Created by Alejandro Gleason on 20/02/21.
//

import UIKit

class ViewController: UITableViewController {
    public var pictures = [Image]()
    
    // Called when the screen has loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        
        // Enables large titles across the app
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Add a Bar Button to recommend the app
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        // Substituted function call "openItems(prefix: "nssl")" to background call ->
        performSelector(inBackground: #selector(openItems), with: "nssl")
        
        let defaults = UserDefaults.standard
        
        // Retrieve the saved people array
        if let savedImages = defaults.object(forKey: "pictures") as? Data {
            // Unpack it as json object
            let jsonDecoder = JSONDecoder()
            // We are going to use a try catch statement for errors
            
            do {
                pictures = try jsonDecoder.decode([Image].self, from: savedImages)
            } catch {
                print("Failed to load people.")
            }
        }
        
        tableView.reloadData()
    }
    
    @objc func openItems(prefix pre: String) {
        let fm = FileManager.default
        let path = Bundle.main.resourcePath
        let items = try? fm.contentsOfDirectory(atPath: path!)
        
        if let its = items {
            for it in its {
                if it.hasPrefix(pre) {
                    let img = Image(times: 0, name: it)
                    pictures.append(img)
                }
            }
        } else {
            print("Error at opening files!")
        }
        
        // Sort in place
        pictures.sort()
        save()
    }
    
    // Action response to share app button
    @objc func shareTapped() {
        let items: [Any] = ["This app is my favorite", URL(string: "https://www.apple.com")!]
        
        // Creates the UI Activity View Controller
        let vc = UIActivityViewController(activityItems: items, applicationActivities: [])
        // Mandatory line so it does not crash on iPad
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
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
        return pictures.count
    }
    
    // Overriding how each row looks like
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Recycling cells (object pool?)
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.font = UIFont(name:"Avenir", size:20)
        // Index path contains both a section number and a row number, here, we only care about the row number
        cell.textLabel?.text = pictures[indexPath.row].imageName
        return cell
    }
    
    // Override what should happen when a row is selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // This is how you instanciate a personalized view controller
        if let vc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController {
            // Updating image count
            pictures[indexPath.row].timesShown += 1
            save()
            // Pushing parameters
            vc.selectedImage = pictures[indexPath.row]
            DetailViewController.totalImages = pictures.count
            vc.currentImage = indexPath.row + 1
            // Pushing and showing the detail view controller
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func save(){
        let jsonEncoder = JSONEncoder()
        
        if let savedData = try? jsonEncoder.encode(pictures) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "pictures")
        } else {
            print("Failed to save pictures.")
        }
    }
   
}

