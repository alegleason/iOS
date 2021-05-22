//
//  ViewController.swift
//  Project10
//
//  Created by Alejandro Gleason on 23/04/21.
//

import UIKit

class ViewController: UICollectionViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var people = [Person]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // setup view components
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPerson))
        
        let defaults = UserDefaults.standard
        
        /*
         Getting the full, unarchived array and putting it into our people property.
         1. We use the object(forKey:) method to pull out an optional Data.
         2. Then give that to the unarchiveTopLevelObjectWithData() method of NSKeyedUnarchiver to convert it back to an object graph (person array).
         */
        if let savedPeople = defaults.object(forKey: "people") as? Data {
            if let decodedPeople = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedPeople) as? [Person] {
                people = decodedPeople
            }
        }

    }
    
    // How many items we want to have?
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return people.count
    }
    
    // What does each item holds?
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Person", for: indexPath) as? PersonCell else {
            // we failed to get a PersonCell
            fatalError("Unable to dequeue PersonCell.")
        }
        
        let person = people[indexPath.item]
        
        cell.Name.text = person.name
        
        let path = getDocumentsDirectory().appendingPathComponent(person.image)
        cell.ImageView.image = UIImage(contentsOfFile: path.path)
        
        cell.ImageView.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
        cell.ImageView.layer.borderWidth = 2
        cell.ImageView.layer.cornerRadius = 3
        cell.layer.cornerRadius = 7

        // if we're still here it means we got a PersonCell, so we can return it
        return cell
    }
    
    @objc func addNewPerson() {
        let picker = UIImagePickerController()
        // users can crop and edit the picture
        picker.allowsEditing =  true
        // in order to be the delegate you must conform to UIImagePickerControllerDelegate and UINavigationControllerDelegate
        picker.delegate = self
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
        
        let person = Person(name: "Unknown", image: imageName)
        people.append(person)
        save()
        collectionView.reloadData()
        
        // This dismiss whatever view controller are we in, in this case, the UIImagePickerController
        dismiss(animated: true)
    }
    
    // Function to read the documents directory wherever we are
    func getDocumentsDirectory() -> URL {
        // we are asking for the documents directory of the specific user we have
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    // Method to rename the person
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let person = people[indexPath.item]
        
        let ac = UIAlertController(title: "Edit cell", message: nil, preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "Rename", style: .default) { [weak self, weak person] _ in
            let ac = UIAlertController(title: "Rename cell", message: nil, preferredStyle: .alert)
            ac.addTextField()

            // Catch the tap action, the _ before the last in is the action recieved, but we are ignoring it
            ac.addAction(UIAlertAction(title: "OK", style: .default) { [weak self, weak ac] _ in
                guard let newName = ac?.textFields?[0].text else { return }
                person?.name = newName
                self?.save()
                self?.collectionView.reloadData()
            })

            ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            self?.present(ac, animated: true)
            return
        })
        
        ac.addAction(UIAlertAction(title: "Delete", style: .default) { [weak self] _ in
            self?.people.remove(at: indexPath.item)
            self?.collectionView.reloadData()
            return
        })
                
        present(ac, animated: true)
    }
    
    func save() {
        
        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: people, requiringSecureCoding: false) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "people")
        }
        
    }


}

