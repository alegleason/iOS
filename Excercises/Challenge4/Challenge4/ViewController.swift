//
//  ViewController.swift
//  Challenge4
//
//  Created by Alejandro Gleason on 24/05/21.
//

import UIKit

class ViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var pictures = [Picture]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        title = "Challenge Day 50"
        
        // Enables large titles across the app
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Add a Bar Button to add more pictures
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPicture))
        
        let defaults = UserDefaults.standard
        
        // Retrieve the saved people array
        if let savedImages = defaults.object(forKey: "pictures") as? Data {
            // Unpack it as json object
            let jsonDecoder = JSONDecoder()
            // We are going to use a try catch statement for errors
            do {
                pictures = try jsonDecoder.decode([Picture].self, from: savedImages)
            } catch {
                print("Failed to load saved pictures.")
            }
        }
    }
    
    // Function to add a new person
    @objc func addNewPicture() {
        let picker = UIImagePickerController()
        // users can crop and edit the picture
        picker.allowsEditing =  true
        // in order to be the delegate you must conform to UIImagePickerControllerDelegate and UINavigationControllerDelegate
        picker.delegate = self
        // ask to use the camera rather than the file system
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            picker.sourceType = .camera
        }
        present(picker, animated: true)
    }
    
    // Function to retrieve the image from theUIImagePickerController
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // typecast to image
        guard let image = info[.editedImage] as? UIImage else { return }
        
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        // Parse the image to jpegData and write to disk
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        
        let picture = Picture(name: imageName, caption: "empty caption", path: imagePath)
        pictures.append(picture)
        save()
        tableView.reloadData()
        
        // This dismiss whatever view controller are we in, in this case, the UIImagePickerController
        dismiss(animated: true)
    }
    
    // Function to read the documents directory wherever we are
    func getDocumentsDirectory() -> URL {
        // we are asking for the documents directory of the specific user we have
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
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
        cell.textLabel?.text = pictures[indexPath.row].caption
        return cell
    }
    
    // Override what should happen when a row is selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // This is how you instanciate a personalized view controller
        if let vc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController {
            // Pushing parameters
            vc.selectedImage = pictures[indexPath.row]
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

