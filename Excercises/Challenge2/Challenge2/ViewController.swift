//
//  ViewController.swift
//  Challenge2
//
//  Created by Alejandro Gleason on 17/03/21.
//

import UIKit

class ViewController: UITableViewController {
    var items = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
        
        // Add a Bar Button to clear the list
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(clearShoppingList))
        
        
        title = "Shopping List"
        
    }
    
    @objc
    func clearShoppingList() {
        items.removeAll()
        // This clears the table WITH an animation while reloadData() does not
        let range = NSMakeRange(0, self.tableView.numberOfSections)
        let sections = NSIndexSet(indexesIn: range)
        self.tableView.reloadSections(sections as IndexSet, with: .automatic)
    }
    
    @objc func addItem() {
        let ac = UIAlertController(title: "Enter item", message: nil, preferredStyle: .alert)
        // Adds a new input text box
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Add", style: .default) {
            // weak self refers to the view controller, ac to the alert controller are not captured strongly - avoids memory leaking
            [weak self, weak ac] _ in // before the 'in' we name the external parameters, after it we state what we want the function to do
            guard let answer = ac?.textFields?[0].text else { return }
            self?.submit(answer)
        }
        // The reason we are using closures is because we need to pass a fn to the addAction() method
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    func submit(_ newItem: String) {
        items.insert(newItem, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        // .automatic performs the "standard" animation
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Item", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }


}

