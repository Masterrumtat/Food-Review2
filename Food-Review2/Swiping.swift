//
//  ViewController.swift
//  Food-Review2
//
//  Created by Vituruch Sinthusate on 14/11/2566 BE.
//



import UIKit

class Swiping: UIViewController {
    
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var dislikeButton: UIButton!
    @IBOutlet weak var cardImageView: UIImageView!
    
    private var images: [String] = []  // Assume you have an array of image names
    
    private var currentImageIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadImagesFromPlist()
        showImage()
        
        // Add a pan gesture recognizer to the cardImageView
    }
    
    func loadImagesFromPlist() {
        if let path = Bundle.main.path(forResource: "restimg", ofType: "plist"),
           let array = NSArray(contentsOfFile: path) as? [String] {
            images = array
            print("Loaded \(images.count) images from plist.")
        } else {
            print("Failed to load images from plist.")
        }
    }
    
    func showImage() {
        guard currentImageIndex < images.count else {
            print("End of images")
            return
        }
        
        let imageName = images[currentImageIndex]
        
        if let image = UIImage(named: imageName) {
            cardImageView.image = image
            print("Showing image: \(imageName)")
        } else {
            print("Image not found: \(imageName)")
        }
    }
}
