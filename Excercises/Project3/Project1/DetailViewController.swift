//
//  DetailViewController.swift
//  Project1
//
//  Created by Alejandro Gleason on 21/02/21.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    // Optional vars to pass to the "constructor"
    static var totalImages: Int?
    var currentImage: Int?
    var selectedImage: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        
        /* Declare an item to be used by the navigation bar button item to show relevant information. Parameters are:
            1. System item: Which icon to show.
            2. Target and action go hand to hand, since it says who's method to call.
            The #selector tells that a method called 'sharedTapped' will exist
         */
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        if let imageToLoad = selectedImage, let currIg = currentImage, let totalIg = DetailViewController.totalImages {
            // If we unwrappe succesfully, update the UIImageView object
            imageView.image = UIImage(named: imageToLoad)
            imageView.restorationIdentifier = imageToLoad
            title = "Picture \(currIg) of \(totalIg)"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // What hide bars on tap does is to make the image view full size on tap
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    @objc func shareTapped() {
        // Retrieve the image the user will share
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
            print("No image found")
            return
        }
        let imageName = imageView.restorationIdentifier!
        
        // Creates the UI Activity View Controller
        let vc = UIActivityViewController(activityItems: [image, imageName], applicationActivities: [])
        // Mandatory line so it does not crash on iPad
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
}
