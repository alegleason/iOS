//
//  DetailViewController.swift
//  Challenge1
//
//  Created by Alejandro Gleason on 01/03/21.
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
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        navigationItem.largeTitleDisplayMode = .never
        
        if let imageToLoad = selectedImage, let currIg = currentImage, let totalIg = DetailViewController.totalImages {
            // If we unwrap succesfully, update the UIImageView object
            imageView.image = UIImage(named: imageToLoad)
            imageView.layer.masksToBounds = true
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
        
        // Creates the UI Activity View Controller
        let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
        // Mandatory line so it does not crash on iPad
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
}
