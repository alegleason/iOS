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
    var selectedImage: Image?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationItem.largeTitleDisplayMode = .never
        
        if let imageToLoad = selectedImage, let currIg = currentImage, let totalIg = DetailViewController.totalImages {
            // If we unwrappe succesfully, update the UIImageView object
            imageView.image = UIImage(named: imageToLoad.imageName)
            title = "Picture \(currIg) of \(totalIg) - times: \(imageToLoad.timesShown)"

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
}
